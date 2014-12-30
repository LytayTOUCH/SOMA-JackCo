class ApplicationController < ActionController::Base
  include ExceptionHandler
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:alert] = "Access denied. You are not authorized to access the requested page."
  #   redirect_to dashboards_path
  # end

  private
  def after_sign_in_path_for(resource)
    dashboards_path
  end

  protected
  def after_update_path_for(resource)
    users_path(resource)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:role, :resource_ids)
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
  end

end
