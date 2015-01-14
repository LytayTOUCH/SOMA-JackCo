class ResourcesController < ApplicationController
  load_and_authorize_resource
  # before_filter :load_permissions

  def index
    begin
      @resource = Resource.new

      if params[:resource] and params[:resource][:name] and !params[:resource][:name].nil?
        @resources = Resource.find_by_name(params[:resource][:name]).page(params[:page]).per(5)
      else
        @resources = Resource.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @resource = Resource.new
  end

  def create   
    @resource = Resource.new(resource_params)
    if @resource.save!
      flash[:notice] = "Resource saved successfully"
      redirect_to resources_path
    else
      flash[:notice] = "Resource can't save"
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
