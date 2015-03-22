class FarmsController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :set_farm, only: [:show, :edit, :update, :destroy]
  before_action :all_active_farm, :all_inactive_farm, :all_farm
  add_breadcrumb "All Farms", :farms_path
  
  def index
    set_title('All Farms')
  end

  def new
    @farm = Farm.new
  end

  def create
    @farm = Farm.new(farm_params)
    if @farm.save
      @farm
      @farms_amount=@farms.count
    end
  end
  
  def edit
  end

  def update
    if @farm.update(farm_params)
      @farm
    end
  end  

  def show
    add_breadcrumb @farm.name, :farm_path
    set_title(@farm.name)
  end

  def destroy
    p "===============B4 Farm Destroy============="
    p @farm.active
    p "========================================"
    @farm.active = false
    @farm.save
    p "===============After Farm Destroy============="
    p @farm.active
    p "========================================"
    # @farm.destroy
    # @farms_amount=@farms.count
  end

  def set_title(name='')
    content_for :title, name
  end

  private
    def all_farm
      @farms = Farm.all
    end
    def all_active_farm
      @farms_active=Farm.where(active: true).all
    end
    def all_inactive_farm
      @farms_inactive=Farm.where(active: false).all
    end
    def set_farm
      @farm = Farm.find(params[:id])
    end
    def farm_params
      params.require(:farm).permit(:name, :location, :latlong_farm)
    end
end
