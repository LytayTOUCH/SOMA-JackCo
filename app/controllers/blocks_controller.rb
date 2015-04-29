class BlocksController < ApplicationController
  add_breadcrumb "All Farms", :farms_path
  before_action :get_farm, only: [:index, :new]
  before_action :set_block, only: [:show, :edit, :update, :destroy]
  def index
    @blocks = Block.where(farm_id: params[:farm_id], active: true)
    add_breadcrumb @farm.name, :farm_blocks_path
  end

  def new
    @planting_projects=PlantingProject.all
    @zones = Zone.where(farm_id: params[:farm_id])
    @block = Block.new
  end

  def edit
    @planting_projects=PlantingProject.all
  end

  def update
    if @block.update(block_params)
      @block
    end
  end

  def show
    add_breadcrumb @block.farm.name, :farm_blocks_path
    add_breadcrumb @block.name, :farm_block_path
  end

  def create
    @block = Block.new(block_params)
    @block.active = true
    if @block.save
      @block
    end
  end

  def destroy
    @block.active=false
    @block.save
  end

  def new_zone
    @zone = Zone.new
    @zones = Zone.where(farm_id: params[:farm_id])
  end

  def create_zone
    @zone = Zone.new(zone_params)
    @zone.farm_id = params[:farm_id]
    if @zone.save
      @zone
    end
  end

  def destroy_zone
    @zone = Zone.find_by(uuid: params[:zone_id])
    @zone.destroy
  end

  def new_area
    @area = Area.new
    @zones = Zone.where(farm_id: params[:farm_id])
    @areas = Area.where(zone_id: params[:zone_id])
  end

  def create_area

  end

  def destroy_area

  end

  def get_tree_amounts
    @get_tree = Block.select("tree_amount").where("uuid=?",params[:block_id]).limit(1)
    render :json => @get_tree
  end

  def get_block_planting_project_data
    @block_data = Block.find_by_uuid(params[:block_id]).planting_project
    render :json => @block_data
  end

  def get_production_by_planting_project
    @production_data = Production.where(planting_project_id: params[:planting_project_id])
    render :json => @production_data
  end  

  def all_active_blocks
    @active_blocks = Block.all.where(farm_id: params[:farm_id], active: true)
  end

  def all_inactive_blocks
    @inactive_blocks = Block.all.where(farm_id: params[:farm_id], active: false)
  end

  def restore_block
    @inactive_blocks = Block.where(farm_id: params[:farm_id], uuid: params[:id])
    @inactive_blocks[0].active = true
    @inactive_blocks[0].save
  end

  def get_areas_by_zone
    @areas = Area.where(zone_id: params[:zone_id])
    render json: @areas
  end

  private
    def get_farm
      @farm = Farm.find_by(uuid: params[:farm_id])
    end
    def set_block
      @block = Block.find(params[:id])
    end

    def block_params
      params.require(:block).permit(:name, :surface, :shape_lat_long, :location_lat_long, :tree_amount, :area_id, :farm_id, :planting_project_id, :rental_status, :status, :fruitful_tree, :active)
    end

    def zone_params
      params.require(:zone).permit(:name, :farm_id)
    end

    def area_params
      params.require(:area).permit(:name, :zone_id)
    end

end
