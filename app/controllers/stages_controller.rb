class StagesController < ApplicationController
  load_and_authorize_resource except: :create
  
  def index
    begin
      @stage = Stage.new

      if params[:stage] and params[:stage][:name] and !params[:stage][:name].nil?
        @stages = Stage.find_by_name(params[:stage][:name]).page(params[:page]).per(5)
      else
        @stages = Stage.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def show
    @stage = Stage.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @stage }
    end
  end

  def new
    @stage = Stage.new
  end

  def create
    begin
      @stage = Stage.new(stage_params)

      if @stage.save!
        flash[:notice] = "Stage saved successfully"
        redirect_to stages_path
      else
        flash[:notice] = "Stage can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @stage = Stage.find(params[:id])
  end

  def update
    begin
      @stage = Stage.find(params[:id])

      if @stage.update_attributes!(stage_params)
        flash[:notice] = "Stage updated"
        redirect_to stages_path
      else
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def stage_params
    params.require(:stage).permit(:name, :period, :note, :fruit_type, :active)
  end
end