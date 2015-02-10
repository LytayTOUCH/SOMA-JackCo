class FarmsController < ApplicationController
  before_action :set_title
  # before_action :set_farm, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "All Farms", :farms_path
  def index
    @farms=Farm.all
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def show
    @farm=Farm.find(params[:id])
    add_breadcrumb @farm.name, :farm_path
  end

  def destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_farm
    #   @farm = Farm.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def farm_params
      params.require(:farm).permit(:name, :location, :latlong_farm)
    end

    def set_title
      content_for :title, "All Farms"
    end

end
