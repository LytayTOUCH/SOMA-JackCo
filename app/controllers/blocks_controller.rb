class BlocksController < ApplicationController
  add_breadcrumb "All Farms", :farms_path
  before_action :set_block, only: [:show, :edit, :update, :destroy]
  def index
    @blocks=Block.where(farm_id: params[:farm_id]).all
    # add_breadcrumb @blocks.select(:farm_id).distinct[0].farm.name, :farm_blocks_path
    @farm_name=@blocks.select(:farm_id).inspect
  end

  def new
    @block = Block.new
    sleep 3
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
