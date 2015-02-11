class FarmsController < ApplicationController
  before_action :set_title
  # before_action :set_farm, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "All Farms", :farms_path
  def index
    @farms=Farm.all
    @farm = Farm.new
  end

  def create

    @farm = Farm.new(farm_params)
    respond_to do |format|
      if @farm.save
        format.html { redirect_to @farm, notice: 'Farm was successfully created.' }
        format.json { render :show, status: :created, location: @farm }
        format.js   { render action: 'show', status: :created, location: @farm }
      else
        format.html { render :new }
        format.json { render json: @farm.errors, status: :unprocessable_entity }
        format.js   { render json: @person.errors, status: :unprocessable_entity }
      end
    end

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
