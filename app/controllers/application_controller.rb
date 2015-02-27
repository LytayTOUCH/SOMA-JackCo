class ApplicationController < ActionController::Base
  include ExceptionHandler
  
  before_action :authenticate_user!, :count_farm, :farm_name_navigator
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
    devise_parameter_sanitizer.for(:sign_up).push(:user_group_id)
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
  end
  
  def count_farm
    @farms_amount=Farm.count(:all)
  end

  def farm_name_navigator
    @farm_names=Farm.pluck(:uuid, :name)
  end
end
