class PermissionsController < ApplicationController

  add_breadcrumb "All User Groups", :user_groups_path

  def new
    @permission = Permission.new
    @user_group = UserGroup.find(params[:id])
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
      @permissions = Permission.all
      @user_group = UserGroup.find(params[:id])
      add_breadcrumb @user_group.name, :edit_permission_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @permission = Permission.find(params[:id])
      if @permission.update_attributes!(permission_params)
        if permission_params[:access_full] == "true" 
          p "=============================================="
          p permission_params[:access_full]
          p "Full true"
          p "=============================================="
          @permission.update_attributes!({:access_list => true, :access_create => true, :access_update => true, :access_delete => true})

        elsif permission_params[:access_full] == nil
          @permission.update_attributes!({:access_full => false})
          @permission.update_attributes!(permission_params)

        else
          p "=============================================="
          p permission_params[:access_full]
          p "FUll false"
          p "=============================================="
          @permission.update_attributes!({:access_list => false, :access_create => false, :access_update => false, :access_delete => false})
        end
         flash[:notice] = "Permission updated"
         redirect_to :back
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
