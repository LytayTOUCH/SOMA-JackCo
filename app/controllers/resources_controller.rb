class ResourcesController < ApplicationController
  def index
    begin
      @resources = Resource.all
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @resource = Resource.new
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @resource = Resource.new(resource_params)
      
      if @resource.save!
        flash[:notice] = "Warehouse type saved successfully"
        redirect_to resources_path
      else
        flash[:notice] = "Warehouse type can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @resource = Resource.find(params[:id])
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @resource = Resource.find(params[:id])
      
      if @resource.update_attributes!(resource_params)
        flash[:notice] = "Resource updated"
        redirect_to resources_path
      else
        flash[:notice] = "Resource can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def resource_params
    params.require(:resource).permit(:name, :note, :active)
  end
end
