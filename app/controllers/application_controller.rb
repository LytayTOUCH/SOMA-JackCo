class ApplicationController < ActionController::Base
  include ExceptionHandler
  
  protect_from_forgery with: :exception

  private
  def after_sign_in_path_for(resource)
    dashboards_path
  end
end
