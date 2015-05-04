class RolesController < ApplicationController
  load_and_authorize_resource except: :create
  # before_filter :load_permissions

  add_breadcrumb "All Roles", :roles_path
  
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
    add_breadcrumb @role.name, :role_path
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    
    if @role.save!
      create_log current_user.uuid, "Created New Role", @role
      flash[:notice] = "Role saved successfully"
      redirect_to roles_path
    else
      flash[:notice] = "Role can't be saved"
      redirect_to :back
    end
  end

  def edit
    @role = Role.find(params[:id])
    add_breadcrumb @role.name, :edit_role_path
  end

  def update
    @role = Role.find(params[:id])

    if @role.update_attributes!(role_params)
      create_log current_user.uuid, "Updated Role", @role
      flash[:notice] = "Role updated"
      redirect_to roles_path
    else
      flash[:notice] = "Role can't be updated"
      redirect_to :back
    end
  end
  private
  def role_params
    params.require(:role).permit!
  end
end
