class ApplicationController < ActionController::Base
  include ExceptionHandler
  include LogHelper
  
  before_action :authenticate_user!, :count_farm, :farm_name_navigator
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  add_breadcrumb "Home", :dashboards_path
  
  def user_for_paper_trail
    # Save the user responsible for the action
    user_signed_in? ? current_user.id : 'Guest'
  end
  
  private
  def after_sign_in_path_for(resource)
    dashboards_path
  end

  protected
  def after_update_path_for(resource)
    users_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:user_group_id, :labor_id)
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
  end
  
  def count_farm
    @farms_amount=Farm.count(:all)
  end

  def farm_name_navigator
    @farm_nav=Farm.where(active: true).all
  end

  rescue_from CanCan::AccessDenied do |exception|  
    flash[:error] = "Access denied!"  
    redirect_to dashboards_path  
  end  

end
