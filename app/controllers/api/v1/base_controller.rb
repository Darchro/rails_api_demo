class Api::V1::BaseController < ApplicationController
  include Pundit
  include ActiveHashRelation
  # disable the CSRF token
  protect_from_forgery with: :null_session

  # disable cookies (no set-cookies header in response)
  before_action :destroy_session

  # disable the CSRF token
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :unauthenticated!

  attr_accessor :current_user

  protected
  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found
    # render json: {status: 404, err_msg: 'not found'}
    return api_error(status: 404, errors: 'Not found')
  end

  def api_error(status: 500, errors: {})
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: jsonapi_format(errors).to_json, status: status
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    user_email = options.blank? ? nil : options[:email]
    user = user_email && User.find_by(email: user_email)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = user
    else
      return unauthenticated!
    end
  end

  def unauthenticated!
    api_error(status: 403, errors: 'not authorized')
  end

  def paginate(resource)
    resource = resource.page(params[:page] || 1)
    if params[:per_page]
      resource = resource.per(params[:per_page])
    end

    return resource
  end

  def meta_attributes(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_pages: object.total_pages,
      total_count: object.total_count
    }
  end

  private
  def jsonapi_format(errors)
    return errors if errors.is_a? String
    errors_hash = {}
    errors.messages.each do |attribute, error|
      array_hash = []
      error.each do |e|
        array_hash << {attribute: attribute, message: e}
      end
      errors_hash.merge!({ attribute => array_hash })
    end

    return errors_hash
  end
end
