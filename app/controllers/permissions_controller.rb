class PermissionsController < ApplicationController
  def new
    @permission = Permission.new
    puts "==========================="
    puts @user_group = UserGroup.find(params[:id])
    puts "==========================="
  end

  def create
    @permission = Permission.new(permission_params)

    if @permission.save!
      flash[:notice] = "Permission saved successfully"
      redirect_to permissions_path
    else
      flash[:notice] = "Permission can't be saved"
      redirect_to :back
    end
  end

  def edit
    begin
      @user_group = UserGroup.find(params[:id])
      @resources = Resource.all
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @permission = Permission.find(params[:id])

      if @permission.update_attributes!(permission_params)
        flash[:notice] = "Permission updated"
        redirect_to permissions_path
      else
        flash[:notice] = "Permission can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def permission_params
    params.require(:permission).permit(:user_group_id, :resource_id, :access_full, :access_list, :access_create, :access_update, :access_delete)
  end
end
