class UserGroupsController < ApplicationController
  load_and_authorize_resource except: :create
  # before_filter :load_permissions

  def index
    @user_groups = UserGroup.all
  end

  def new
    @user_group = UserGroup.new
  end

  def create   
    @user_group = UserGroup.new(user_group_params)
    if @user_group.save!
      flash[:notice] = "Warehouse type saved successfully"
      redirect_to user_groups_path
    else
      flash[:notice] = "Warehouse type can't save"
      redirect_to :back
    end
  end

  def show
    @user_group = UserGroup.find(params[:id])
  end

  def edit
    @user_group = UserGroup.find(params[:id])
  end

  def update
    @user_group = UserGroup.find(params[:id])
    if @user_group.update_attributes!(user_group_params)
      flash[:notice] = "User Group updated"
      redirect_to user_groups_path
    else
      redirect_to :back
    end
  end

  private
  def user_group_params
    params.require(:user_group).permit(:name, :note, :active)
  end
end
