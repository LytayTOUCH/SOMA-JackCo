class PlanFarmsController < ApplicationController

  def index
    @plan_farms = PlanFarm.all
  end

  def new
    @locations = PlanFarm.new
    @phase = @locations.plan_phases.build
    @stage = @phase.plan_production_stages.build
  end

  def create
    @locations = PlanFarm.new(location_params)

    if @locations.save
      create_log current_user.uuid, "Created New Plan Farm", @locations
      flash[:notice] = "Plan Form saved successfully"
      redirect_to plan_farms_path
    else
      render 'new'
    end
  end

  def edit
    @locations = PlanFarm.find(params[:id])
  end

  def update
    @locations = PlanFarm.find(params[:id])

    if @locations.update_attributes(location_params)
      if params[:plan_farm][:status] == "false"
          create_log current_user.uuid, "Deactivated Plan Farm", @locations
      elsif params[:plan_farm][:status] == "true"
        create_log current_user.uuid, "Activated Plan Farm", @locations
      end

      if params[:plan_farm][:status] == "1" or params[:plan_farm][:status] == "0"
        create_log current_user.uuid, "Updated Plan Farm", @locations  
      end 
      flash[:notice] = "Plan farm updated successfully"
      redirect_to plan_farms_path
    else
      flash[:notice] = "Plan farm can't be updated"
      render 'edit'
    end
  end

  def get_production_stages
    stage = ProductionStage.where(phase_id: params[:phase_id])
    render :json => stage
  end

  def get_render_block
    @production_status = ProductionStatus.where(stage_id: params[:stage_id])
    
    @farm = Farm.find(params[:farm_id])

    @locations = PlanFarm.new

    @locations.farm_id = params[:farm_id]
    @locations.for_year = params[:for_year]
    @locations.planting_project_id = params[:planting_project_id]
    
    @phase = @locations.plan_phases.build
    @phase.phase_id = params[:phase_id]
    @stage = @phase.plan_production_stages.build
    @stage.production_stage_id = params[:stage_id]

    @production_status.each do |ps|
      @status = @stage.plan_production_statuses.build
      @status.production_status_id = ps.uuid

      @farm.zones.each do |zn|
        @zone = @status.plan_zones.build
        @zone.zone_id = zn.uuid

        zn.areas.each do |ar|
          @area = @zone.plan_areas.build
          @area.area_id = ar.uuid

          ar.blocks.each do |block|
             @block = @area.plan_blocks.build
             @block.block_id = block.uuid
          end
        end
      end
    end
    
    render partial: 'form'
  end

  def get_zone_by_farm
    zone = Zone.where(farm_id: params[:farm_id])
    render :json => zone
  end

  private
  def location_params
    params.require(:plan_farm).permit(
      :id, :farm_id, :planting_project_id, :for_year, :status,
      plan_phases_attributes: [:id, :phase_id, :plan_farm_id,
        plan_production_stages_attributes: [:id, :plan_phase_id, :production_stage_id,
          plan_production_statuses_attributes: [:id, :plan_production_stage_id, :production_status_id, :remark,
            plan_zones_attributes: [:id, :zone_id, :plan_production_status_id,
              plan_areas_attributes: [:id, :plan_zone_id, :area_id,
                plan_blocks_attributes: [:id, :block_id, :tree_amount, :plan_area_id
                ]
              ]
           ]
         ]
        ]
      ]
    )
  end
end
