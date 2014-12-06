class Registrations::RegistrationsController < Devise::RegistrationsController
  
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

# protected
# def after_sign_up_path_for(resource)
#   super(resource)
# end

  # GET /resource/sign_up
  def new
    super
    @user = User.new
  end

  # POST /resource
  def create
    puts "==============================="
    puts @user = User.new(user_params)
    puts @user.resource_ids = params[:user][:resource_ids]
    puts "==============================="
    
    # puts "====================================="
    # puts @user
    # puts "====================================="
    if @user.save!
      flash[:notice] = "User has been created successfully"
      redirect_to new_user_session_path
    else
      flash[:notice] = "User can't save"
      redirect_to :back
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :role)
  end

end
