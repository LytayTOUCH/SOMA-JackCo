class SettingsController < ApplicationController
  add_breadcrumb "All Settings", :settings_path
  
  def index
    @settings = Setting.all
  end
  
  def show
    @setting = Setting.find_by(code: params[:code])
    add_breadcrumb @setting.code, :edit_setting_path
  end
  
  def edit
    begin
      @setting = Setting.find_by(code: params[:code])
      add_breadcrumb @setting.code, :edit_setting_path
    rescue Exception => e
      puts e
    end
  end
end
