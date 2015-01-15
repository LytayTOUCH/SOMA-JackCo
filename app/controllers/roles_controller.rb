class RolesController < ApplicationController
  load_and_authorize_resource
  # before_filter :load_permissions
  
  respond_to :html, :json
  # load_and_authorize_resource

  def index
    begin
      @role = Role.new

      if params[:role] and params[:role][:name] and !params[:role][:name].nil?
        @roles = Role.find_by_name(params[:role][:name]).page(params[:page]).per(5)
      else
        @roles = Role.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    
    if @role.save!
      flash[:notice] = "Role saved successfully"
      redirect_to roles_path
    else
      flash[:notice] = "Role can't be saved"
      redirect_to :back
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes!(role_params)
      flash[:notice] = "User Group updated"
      redirect_to roles_path
    else
      redirect_to :back
    end
  end
  private
  def role_params
    params.require(:role).permit!
  end
end