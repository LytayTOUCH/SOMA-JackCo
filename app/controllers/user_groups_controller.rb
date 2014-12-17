class UserGroupsController < ApplicationController
  def index
    begin
      @user_groups = UserGroup.all
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @user_group = UserGroup.new
    rescue Exception => e
      puts e
    end
  end

  def create   
    begin
      @user_group = UserGroup.new(user_group_params)

      if @user_group.save!
        flash[:notice] = "Warehouse type saved successfully"
        redirect_to user_groups_path
      else
        flash[:notice] = "Warehouse type can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def show
    begin
      @user_group = UserGroup.find(params[:id])
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @user_group = UserGroup.find(params[:id])
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @user_group = UserGroup.find(params[:id])
      
      if @user_group.update_attributes!(user_group_params)
        flash[:notice] = "User Group updated"
        redirect_to user_groups_path
      else
        flash[:notice] = "User Group can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def user_group_params
    params.require(:user_group).permit(:name, :note, :active)
  end
end
