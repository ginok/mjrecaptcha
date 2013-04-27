class UsersController < ApplicationController
  before_action :require_login

  def current_user
    return nil if session[:signap_user_id].nil?
    @_current_user ||= User.find(session[:signap_user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def show
    @user = current_user
  end

  def require_login
    unless logged_in?
      redirect_to signap.login_path
    end
  end
end
