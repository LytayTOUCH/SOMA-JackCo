class PositionsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Position", :positions_path
  
  def index
    begin
      @position = Position.new

      if params[:position] and params[:position][:name] and !params[:position][:name].nil?
        @positions = Position.find_by_position_name(params[:position][:name]).page(params[:page]).per(5)
      else
        @positions = Position.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @position = Position.new
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @position = Position.new(position_params)

      if @position.save!
        flash[:notice] = "Production Status type saved successfully"
        redirect_to positions_path
      else
        flash[:notice] = "Production Status type can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @position = Position.find(params[:id])
      add_breadcrumb @position.name, :edit_position_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @position = Position.find(params[:id])

      if @position.update_attributes!(position_params)
        flash[:notice] = "Production Stage updated"
        redirect_to positions_path
      else
        flash[:notice] = "Production Stage can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def position_params
    params.require(:position).permit(:name, :note, :active)
  end
end