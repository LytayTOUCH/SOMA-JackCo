class UsersController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Users", :users_path

  def index
    begin
      @users = User.order("email ASC")
    rescue Exception => e
      puts e
    end
  end

  def show
    @user = User.find(params[:id])
    add_breadcrumb @user.email, :user_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    create_log current_user.uuid, "Create New User", @user
    
    if @user.save
      @labor = Labor.find_by_uuid(@user.labor_id)
      @labor.update_attributes!(selected: true)

      flash[:notice] = "User has been created successfully"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit_profile
    @user_account = User.find(params[:id])
    add_breadcrumb @user_account.email, :edit_profile_user_path
  end

  def update_profile
    @user_account = User.find(params[:id])
    create_log current_user.uuid, "Updated User Profile", @user_account

    if @user_account.update_attributes(account_update_params)
      flash[:notice] = "User updated"
      redirect_to users_path
    else
      render 'edit_profile'
    end
  end

  def edit
    @user = User.find(params[:id])
    add_breadcrumb @user.email, :edit_user_path
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      create_log current_user.uuid, "Updated User", @user
      flash[:notice] = "User updated"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :user_group_id, :labor_id, :active)
  end

  private
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

end