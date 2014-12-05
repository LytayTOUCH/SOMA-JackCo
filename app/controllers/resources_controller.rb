class ResourcesController < ApplicationController
  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
  end

  def create   
    @resource = Resource.new(resource_params)
    if @resource.save!
      flash[:notice] = "Warehouse type saved successfully"
      redirect_to resources_path
    else
      flash[:notice] = "Warehouse type can't save"
      redirect_to :back
    end
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes!(resource_params)
      flash[:notice] = "Resource updated"
      redirect_to resources_path
    else
      redirect_to :back
    end
  end

  private
  def resource_params
    params.require(:resource).permit(:name, :note, :active)
  end
end
