class LocationsController < ApplicationController
  def index
  end

  def new
    @locations = PlanFarm.new
    @phase = @locations.plan_phases.build
    @stage = @phase.plan_production_stages.build
    @status = @stage.plan_production_statuses.build
    5.times { @status.plan_areas.build }
  end

  def create
    binding.pry

    @plan_location = PlanFarm.new(location_params)

    if @plan_location.save
      # redirect_to root_path
    else
      render 'new'
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

  def get_areas_by_farm
    @blocks = Block.where(farm_id: params[:farm_id])
    @status_line = params[:status_line]

    # binding.pry
    render partial: 'area'
  end

  private
  def location_params
    params.require(:plan_farm).permit(
      :uuid, :farm_id, :for_year,
      plan_phases_attributes: [:uuid, :phase_id, :plan_farm_id,
        plan_production_stages_attributes: [:uuid, :production_stage_id,
          plan_production_statuses_attributes: [:uuid, :production_status_id, :remark,
           plan_areas_attributes: [:uuid, :block_id, :tree_amount
           ]
         ]
        ]
      ]
    )
  end

end
