class RolesController < ApplicationController
  respond_to :html, :json
  # load_and_authorize_resource

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
    # @user_groups = UserGroup.select(:name).distinct
    @resources = Resource.all
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

  def resources
    resources = Resource.where("name like? ", "%#{params[:q]}%")

    respond_to do |format|
      format.html
      format.json {render json: resources.map {|resource| {id: resource.id, text: resource.name}}}
    end
  end

  private
  def role_params
    params.require(:role).permit!
  end
end
