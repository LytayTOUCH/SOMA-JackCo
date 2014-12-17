class RolesController < ApplicationController
  # load_and_authorize_resource

  def index
    begin
      @roles = Role.all
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @role = Role.new
      @resources = Resource.all
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @role = Role.new(role_params)
      
      if @role.save!
        flash[:notice] = "Role saved successfully"
        redirect_to roles_path
      else
        flash[:notice] = "Role can't be saved"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def resources
    begin
      resources = Resource.where("name like? ", "%#{params[:q]}%")

      respond_to do |format|
        format.html
        format.json {render json: resources.map {|resource| {id: resource.id, text: resource.name}}}
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def role_params
    params.require(:role).permit!
  end
end
