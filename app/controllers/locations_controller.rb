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
    @plan_location = PlanFarm.new(location_params)
    binding.pry

    if @plan_location.save
      # redirect_to root
    else
      render 'new'
    end
  end

  def show
    
  end

  private
  def location_params
    params.require(:plan_farm).permit(
      :uuid, :farm_id, :for_year,
      plan_phases_attributes: [:uuid, :phase_id, :plan_farm_id, :remark,
        plan_production_stages_attributes: [:uuid, :production_stage_id,
          plan_production_statuses_attributes: [:uuid, :production_status_id,
           plan_areas_attributes: [:uuid, :block_id, :tree_amount]
           ]
          ]
        ]
      )
  end

end
