class ApplicationController < ActionController::Base
  protect_from_forgery

#  before_filter :authenticate_user!
#
#  layout :layout_by_resource
#
#  protected
#
#  def after_sign_out_path_for(resource_or_scope)
#    new_user_session_path
#  end
#
#  def after_sign_in_path_for(resource_or_scope)
#    categories_path
#  end
#
#  def after_inactive_sign_up_path_for(resource_or_scope)
#     categories_path
#  end
#
#  def layout_by_resource
#    if devise_controller?
#      "start_page"
#    else
#      "application"
#    end
#  end


  def current_user
    User.last
  end

  helper_method :current_user

end
