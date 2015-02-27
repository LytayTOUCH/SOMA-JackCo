class FarmsController < ApplicationController
  load_and_authorize_resource except: :create
  add_breadcrumb "All Farms", :farms_path
  
  def index
    set_title('All Farms')
    @farms=Farm.all
    @farm = Farm.new
  end

  def new
    @farm = Farm.new
  end

  def create
    @farm = Farm.new(farm_params)
    if @farm.save
      @notice = @farm.errors.any?
    else
      @notice = @farm.errors.any?
    end
  end
  
  def edit
    
  end
  
  def show
    @farm=Farm.find(params[:id])
    add_breadcrumb @farm.name, :farm_path
    set_title(@farm.name)
  end

  def destroy
    @farm = Farm.find(params[:id])
    @farm.destroy
    redirect_to farms_path
  end

  def set_title(name='')
    content_for :title, name
  end

  private 
    def farm_params
      params.require(:farm).permit(:name, :location, :latlong_farm)
    end
end
