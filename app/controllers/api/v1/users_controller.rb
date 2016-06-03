class Api::V1::UsersController < Api::V1::BaseController

  before_action :authenticate_user!, only: [:update]

  def index
    users = User.all
    users = apply_filters(users, params)
    render(
      json: ActiveModel::ArraySerializer.new(
        users, 
        each_serializer: Api::V1::UserSerializer#,
        # root: users
      )
    )
  end

  def show
    user = User.find(params[:id])
    # render json: {user: user}
    render(json: Api::V1::UserSerializer.new(user).to_json)
  end

  def update
    user = User.find(params[:id])
    authorize user

    if !user.update_attributes(update_params)
      return api_error(status: 422, errors: user.errors)
    end

    render(
      json: Api::V1::UserSerializer.new(user).to_json,
      status: 200,
      location: api_v1_user_path(user.id),
      serializer: Api::V1::UserSerializer
    )
  end

  private
  def update_params
    params.require(:user).permit(:name)
  end
end
