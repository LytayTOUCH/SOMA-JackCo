class UserGroupsController < ApplicationController
  load_and_authorize_resource except: :create
  # before_filter :load_permissions

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
    @permission = Permission.new
  end

  def create   
    @user_group = UserGroup.new(user_group_params)
    @user_group.resource_ids = params[:user_group][:resource_ids]
    
    if @user_group.save!
      flash[:notice] = "User Group type saved successfully"
      redirect_to user_groups_path
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
    # permission_actions_attributes: [:access_full, :access_list, :access_create, :access_update, :access_delete]
  end
end
