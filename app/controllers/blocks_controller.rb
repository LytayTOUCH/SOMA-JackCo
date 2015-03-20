class BlocksController < ApplicationController
  add_breadcrumb "All Farms", :farms_path
  before_action :get_farm, only: [:index, :new]
  before_action :set_block, only: [:show, :edit, :update, :destroy]
  def index
    @blocks = Block.all.where(farm_id: params[:farm_id])
    add_breadcrumb @farm.name, :farm_blocks_path
  end

  def new
    @planting_projects=PlantingProject.all
    @block = Block.new
  end

  def show
    add_breadcrumb @block.farm.name, :farm_blocks_path
    add_breadcrumb @block.name, :farm_block_path
  end

  def create
    # p "==============================="
    # p block_params
    # p "==============================="
    @block = Block.new(block_params)
    if @block.save
      @block
    end
  end

  private
    def get_farm
      @farm = Farm.find_by(uuid: params[:farm_id])
    end
    def set_block
      @block = Block.find(params[:id])
    end
    def block_params
      params.require(:block).permit(:name, :surface, :shape_lat_long, :location_lat_long, :tree_amount, :farm_id, :planting_project_id, :rental_status, :status)
    end

end
