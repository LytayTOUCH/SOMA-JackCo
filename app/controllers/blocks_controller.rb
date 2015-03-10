class BlocksController < ApplicationController
  add_breadcrumb "All Farms", :farms_path
  before_action :set_block, only: [:show, :edit, :update, :destroy]
  def index
    @farm = Farm.find_by(uuid: params[:farm_id])
    @blocks = Block.all.where(farm_id: params[:farm_id])
    add_breadcrumb @farm.name, :farm_blocks_path
  end

  def new
    @block = Block.new
  end

  def show
    add_breadcrumb @block.farm.name, :farm_blocks_path
    add_breadcrumb @block.name, :farm_block_path
  end

  def create
    @block = Farm.new(block_params)
    if @block.save
      @block
    end
  end

  private
    def set_block
      @block = Block.find(params[:id])
    end
    def block_params
      params.require(:block).permit(:name, :surface, :shape_lat_long, :location_lat_long, :tree_amount, :farm_id, :planting_project_id, :rental_status, :status)
    end

end
