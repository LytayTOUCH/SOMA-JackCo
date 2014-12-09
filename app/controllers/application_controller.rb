class ApplicationController < ActionController::Base
  include ExceptionHandler
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private
  def after_sign_in_path_for(resource)
    dashboards_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:role, :resource_ids)
  end

end
