class Api::V1::MicropostsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    user = User.find_by(id: params[:user_id])
    microposts = user.microposts
    microposts = apply_filters(microposts, params)
    microposts = paginate(user.microposts)
    authorize user
    
    render(
      json: ActiveModel::ArraySerializer.new(
        microposts,
        each_serializer: Api::V1::MicropostSerializer,
        root: 'microposts',
        meta: meta_attributes(microposts)
      )
    )
  end
end
