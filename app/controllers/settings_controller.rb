class SettingsController < ApplicationController
  add_breadcrumb "All Settings", :settings_path
  
  def index
    @settings = Setting.all
  end
  
  def show
    @setting = Setting.find_by(code: params[:code])
  end
  
  def edit
    begin
      @setting = Setting.find_by(code: params[:code])
      add_breadcrumb @setting.code, :edit_setting_path
    rescue Exception => e
      puts e
    end
  end
  
  def update
    @setting = Setting.find(params[:code])
    create_log current_user.uuid, "Updated Setting", @setting

    if @setting.update_attributes(setting_params)
      
      if params[:code] == "item_per_page"
        session[:item_per_page] = @setting.valueInteger
      end
      
      flash[:notice] = "Setting updated"
      redirect_to settings_path
    else
      # redirect_to :back
      render 'edit'
    end
  end
  
  private
  def setting_params
    params.require(:setting).permit(:valueInteger, :valueString, :valueFloat)
  end
end
