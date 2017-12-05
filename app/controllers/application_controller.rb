class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    # if before_action current_user.nil?
    #   redirect_to root_path
    # else
      edit_user_path(current_user)
    # end
  end
end
