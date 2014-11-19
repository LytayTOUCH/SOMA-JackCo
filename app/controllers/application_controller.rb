class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource

  def layout_by_resource
    boolean = devise_controller? and user_signed_in?
    if boolean
      'sign_in'
    else
      'application'
    end
  end

  def after_sign_in_path_for(resource)
    dashboards_path
  end
end
