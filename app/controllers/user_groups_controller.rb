class UserGroupsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All User Groups", :user_groups_path

  def index
    begin
      @user_groups = UserGroup.all
    rescue Exception => e
      puts e
    end
  end

  def new
    @user_group = UserGroup.new
  end

  def create   
    @user_group = UserGroup.new(user_group_params)
    
    if @user_group.save
      flash[:notice] = "This user group is not active yet. Please contact us for activate this user group."
      redirect_to user_groups_path(@user_group)
    else
      render 'new'
    end
  end

  def show
    @user_group = UserGroup.find(params[:id])
  end

  def edit
    @user_group = UserGroup.find(params[:id])
    add_breadcrumb @user_group.name, :edit_user_group_path
  end

  def update
    @user_group = UserGroup.find(params[:id])

    if @user_group.update_attributes(user_group_params)
      flash[:notice] = "User Group updated"
      redirect_to user_groups_path
    else
      render 'edit'
    end
  end

  private
  def user_group_params
    params.require(:user_group).permit(:name, :note, :active)
  end
end
