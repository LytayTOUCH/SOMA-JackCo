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

  def edit
    @planting_projects=PlantingProject.all
  end

  def update
    p "=============Block Params==================="
    p block_params
    p "================================"
    p "=============Block Object==================="
    p @block
    p "================================"
    # if @block.update(block_params)
    #   @block
    # end
  end

  def show
    add_breadcrumb @block.farm.name, :farm_blocks_path
    add_breadcrumb @block.name, :farm_block_path
  end

  def create
    @block = Block.new(block_params)
    if @block.save
      @block
    end
  end

  def get_tree_amounts
    @get_tree = Block.select("tree_amount").where("uuid=?",params[:block_id]).limit(1)
    render :json => @get_tree
  end

  def get_block_planting_project_data
    # @planting_project_id = Block.select("planting_project_id").find_by_uuid(params[:block_id])
    # @block_data = PlantingProject.select("uuid, name").where("uuid = ?", @planting_project_id)
    # @block_data = Block.joins(:planting_project).select("planting_project.uuid, planting_project.name").where("uuid = ?", params[:block_id])
    @block_data = Block.find_by_uuid(params[:block_id]).planting_project
    render :json => @block_data
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
