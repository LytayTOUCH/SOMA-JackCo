class ProductionStagesController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Production Stages", :production_stages_path
  
  def index
    begin
      @production_stage = ProductionStage.new

      if params[:production_stage] and params[:production_stage][:name] and !params[:production_stage][:name].nil?
        @production_stages = ProductionStage.find_by_production_stage_name(params[:production_stage][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @production_stages = ProductionStage.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @production_stage = ProductionStage.new
      @phases = Phase.all
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @production_stage = ProductionStage.new(production_stage_params)

      if @production_stage.save
        create_log current_user.uuid, "Created New Production Stage", @production_stage
        flash[:notice] = "Production Status saved successfully"
        redirect_to production_stages_path
      else
        flash[:notice] = "Production Status can't be saved"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @production_stage = ProductionStage.find(params[:id])
      @phases = Phase.all
      add_breadcrumb @production_stage.name, :edit_production_stage_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @production_stage = ProductionStage.find(params[:id])

      if @production_stage.update_attributes(production_stage_params)
        create_log current_user.uuid, "Updated Production Stage", @production_stage
        flash[:notice] = "Production Stage updated"
        redirect_to production_stages_path
      else
        flash[:notice] = "Production Stage can't be updated"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def production_stage_params
    params.require(:production_stage).permit(:name, :planting_project_id, :phase_id, :note, :active)
  end
end
