class PlanLocationsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  def index
    if !params[:filter].nil? && params[:filter][:year]!=""
      @year = params[:filter][:year]
      @location_plan = LocationPlan.find_by(year: @year, planting_project_id: params[:filter][:planting_project_id])
      unless @location_plan.nil?
        @phase_data = JSON.parse(LocationPlanPhase.where(planting_project_id: params[:filter][:planting_project_id]).select("uuid, name").to_json(include:{location_plan_stages:{include: :location_plan_statuses}}))
        
        arr = Array.new
        project = PlantingProject.find(params[:filter][:planting_project_id])
        project.farms.distinct.each do |farm|
          arr.push({uuid: farm.uuid,name: farm.name,zones: JSON.parse(project.zones.where(farm_id: farm.uuid).distinct.select("zones.uuid, zones.name").to_json(include: :areas))})
        end
        @farm_data = JSON.parse arr.to_json
        
        @location_colspan = 0
        @farm_data.each do |farm|
          farm["zones"].each do |zone|
            @location_colspan += zone["areas"].length
          end
        end
        
        @status_id = LocationPlanPhase.where(planting_project_id: params[:filter][:planting_project_id]).first.location_plan_stages.first.location_plan_statuses.first.uuid
      end
    end
  end

  def new
    @year = params[:year]
    @planting_project = PlantingProject.find(params[:planting_project_id])
  end
  
  def create
    @location_plan = LocationPlan.new(year: params[:year], planting_project_id: params[:planting_project_id])
    if @location_plan.save
      create_log current_user.uuid, "Created New Location Plan", @location_plan
      
      phase_data = JSON.parse(LocationPlanPhase.where(planting_project_id: params[:planting_project_id]).select("uuid, name").to_json(include:{location_plan_stages:{include: :location_plan_statuses}}))
      
      txt_index = 0
      other_index = 0
      
      phase_data.each do |phase|
        phase["location_plan_stages"].each do |stage|
          stage["location_plan_statuses"].each do |status|
            
            #LocationPlanTree
            params[:area].each do |area|
              zone = Area.find(area).zone
              LocationPlanTree.create(location_plan_id: @location_plan.uuid, status_id: status["uuid"], area_id: area, zone_id: zone.uuid, farm_id: zone.farm.uuid, tree_value: params[:tree_value][txt_index])
              txt_index+=1
            end
            
            #LocationPlanOther
            LocationPlanOther.create(location_plan_id: @location_plan.uuid, status_id: status["uuid"], spacing: params[:spacing][other_index], remark: params[:remark][other_index], total: params[:total][other_index])
            other_index+=1
          end
        end
      end
      
      flash[:notice] = "Location Plan save successfully"
      redirect_to plan_locations_index_path+"?filter[year]="+params[:year]+"&filter[planting_project_id]="+params[:planting_project_id]
    else
      flash[:notice] = "Process & Implement Plan can't be saved."
      redirect_to plan_locations_new_path+"?year="+params[:year]+"&planting_project_id="+params[:planting_project_id]
    end
  end
end
