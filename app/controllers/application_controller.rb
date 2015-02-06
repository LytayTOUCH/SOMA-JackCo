class ApplicationController < ActionController::Base
  include ExceptionHandler
  
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  add_breadcrumb "Home", :dashboards_path
  private
  def after_sign_in_path_for(resource)
    dashboards_path
  end

  protected
  def after_update_path_for(resource)
    users_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:role, :resource_ids)
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
  end
end
