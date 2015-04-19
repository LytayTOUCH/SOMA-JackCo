class LocationsController < ApplicationController
  def index
    @plan_farms = PlanFarm.all
  end

  def new
    @locations = PlanFarm.new
    @phase = @locations.plan_phases.build
    @stage = @phase.plan_production_stages.build
    # @status = @stage.plan_production_statuses.build
    # 5.times { @status.plan_blocks.build }
  end

  def create
    @plan_farm = PlanFarm.new(location_params)

    if @plan_farm.save
      redirect_to locations_path
    else
      render 'new'
    end
  end

  def edit
    # binding.pry
    @locations = PlanFarm.find(params[:id])
    @selected_zone = Block.find(@locations.plan_blocks.first.block_id).area.zone
  end

  def update
    @plan_farm = PlanFarm.find(params[:id])

    if @plan_farm.update_attributes(location_params)
      flash[:notice] = "Plan farm updated successfully"
      redirect_to locations_path
    else
      flash[:notice] = "Plan farm can't update"
      render 'edit'
    end
  end

  def get_production_stages
    stage = ProductionStage.where(phase_id: params[:phase_id])
    render :json => stage
  end

  def get_production_statuses
    status = ProductionStatus.where(stage_id: params[:stage_id])
    render :json => status
  end

  def get_areas_by_zone
    @areas = Area.where(zone_id: params[:zone_id])
    
    @status_line = params[:status_line]

    render partial: 'area'
  end

  def get_zone_by_farm
    zone = Zone.where(farm_id: params[:farm_id])
    render :json => zone
  end

  private
  def location_params
    params.require(:plan_farm).permit(
      :uuid, :farm_id, :for_year, :status,
      plan_phases_attributes: [:uuid, :phase_id, :plan_farm_id,
        plan_production_stages_attributes: [:uuid, :production_stage_id,
          plan_production_statuses_attributes: [:uuid, :production_status_id, :remark,
            plan_areas_attributes: [:uuid, :plan_production_status_id, :area_id,
              plan_blocks_attributes: [:uuid, :block_id, :tree_amount, :plan_area_id
              ]
           ]
         ]
        ]
      ]
    )
  end

end
