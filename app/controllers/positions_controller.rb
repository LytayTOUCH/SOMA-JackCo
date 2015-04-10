class PositionsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Position", :positions_path
  
  def index
    @positions = Position.order(created_at: :desc)
  end

  def new
    @position = Position.new
  end

  def create
    begin
      @position = Position.new(position_params)

      if @position.save
        flash[:notice] = "Production Status type saved successfully"
        redirect_to positions_path
      else
        render "new"
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @position = Position.find(params[:id])
    add_breadcrumb @position.name, :edit_position_path
  end

  def update
    begin
      @position = Position.find(params[:id])

      if @position.update_attributes!(position_params)
        flash[:notice] = "Production Stage updated"
        redirect_to positions_path
      else
        render "edit"
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
