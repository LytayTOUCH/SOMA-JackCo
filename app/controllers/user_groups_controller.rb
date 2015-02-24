class UserGroupsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All User Groups", :user_groups_path

  def index
    begin
      @user_group = UserGroup.new

      if params[:user_group] and params[:user_group][:name] and !params[:user_group][:name].nil?
        @user_groups = UserGroup.find_by_name(params[:user_group][:name]).page(params[:page]).per(5)
      else
        @user_groups = UserGroup.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @user_group = UserGroup.new
    @resources = Resource.all
  end

  def create   
    @user_group = UserGroup.new(user_group_params)
    @user_group.resource_ids = params[:user_group][:resource_ids]

    if @user_group.save!
      flash[:notice] = "User Group type saved successfully"
      redirect_to edit_permission_path(@user_group)
    else
      flash[:notice] = "User Group type can't save"
      redirect_to :back
    end
  end

  def show
    @user_group = UserGroup.find(params[:id])
  end

  def edit
    @user_group = UserGroup.find(params[:id])
    @resources = Resource.all
    @permission = Permission.new
    add_breadcrumb @user_group.name, :edit_user_group_path
  end

  def update
    @user_group = UserGroup.find(params[:id])
    @user_group.resource_ids = params[:user_group][:resource_ids]

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
