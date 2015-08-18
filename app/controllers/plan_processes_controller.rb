class PlanProcessesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
 
  def index
    if !params[:filter].nil? && params[:filter][:year]!=""
      @year = params[:filter][:year]
      @plan_process = ProcessPlan.find_by(year: @year, planting_project_id: params[:filter][:planting_project_id])
    end
  end
  
  def new
    @year = params[:year]
    @planting_project_id = params[:planting_project_id]
  end
  
  def create
    @process_plan = ProcessPlan.new(year: params[:year], planting_project_id: params[:planting_project_id])
    if @process_plan.save
      create_log current_user.uuid, "Created New Process & Implement Plan", @process_plan
      app_data = JSON.parse App.where("planting_project_id = ?", params[:planting_project_id]).order(:created_at).to_json(:include => :app_descriptions)
      
      ip_1_checkbox_index = 0
      ip_2_checkbox_index = 0
      ip_3_checkbox_index = 0
      ip_4_checkbox_index = 0
      ip_5_checkbox_index = 0
      ip_6_checkbox_index = 0
      labor_checkbox_index = 0
      machinery_checkbox_index = 0
      other_checkbox_index = 0
      
      schedule_checkbox_index = 0
      
      app_data.each do |app|
        app['app_descriptions'].each do |app_description|
          ip_1_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-ip-1-000000001", params[:l_ip_1], params[:v_ip_1], ip_1_checkbox_index
          ip_2_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-ip-2-000000002", params[:l_ip_2], params[:v_ip_2], ip_2_checkbox_index
          ip_3_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-ip-3-000000003", params[:l_ip_3], params[:v_ip_3], ip_3_checkbox_index
          ip_4_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-ip-4-000000004", params[:l_ip_4], params[:v_ip_4], ip_4_checkbox_index
          ip_5_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-ip-5-000000005", params[:l_ip_5], params[:v_ip_5], ip_5_checkbox_index
          ip_6_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-ip-6-000000006", params[:l_ip_6], params[:v_ip_6], ip_6_checkbox_index
          labor_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-labor-00000007", params[:l_labor], params[:v_labor], labor_checkbox_index
          machinery_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-machinery-0008", params[:l_machinery], params[:v_machinery], machinery_checkbox_index
          other_checkbox_index = save_process_plan_material @process_plan.uuid, app["uuid"], app_description["uuid"], "process-plan-category-other-00000009", params[:l_other], params[:v_other], other_checkbox_index
          
          schedule_checkbox_index = save_process_plan_schedule @process_plan.uuid, app["uuid"], app_description["uuid"], schedule_checkbox_index
        end
      end
      
      flash[:notice] = "Process & Implement Plan save successfully"
      redirect_to plan_processes_index_path+"?filter[year]="+params[:year]+"&filter[planting_project_id]="+params[:planting_project_id]
    else
      flash[:notice] = "Process & Implement Plan can't be saved."
      redirect_to plan_processes_new_path+"?year="+params[:year]+"&planting_project_id="+params[:planting_project_id]
    end
  end
  
  private
  def save_process_plan_material process_plan_id, app_id, app_description_id, process_plan_category_id, params_label, params_value, checkbox_index
    if params_label.present?
      params_label.each do |material_label|
        ProcessPlanMaterial.create(process_plan_id: process_plan_id,
                                   app_id: app_id,
                                   app_description_id: app_description_id,
                                   process_plan_category_id: process_plan_category_id,
                                   material_label: material_label,
                                   material_value: params_value[checkbox_index])
        checkbox_index+=1
      end
    end
    return checkbox_index
  end
  
  def save_process_plan_schedule process_plan_id, app_id, app_description_id, checkbox_index
    ProcessPlanSchedule.create(process_plan_id: process_plan_id,
                               app_id: app_id,
                               app_description_id: app_description_id,
                               jan: params[:jan][checkbox_index],
                               feb: params[:feb][checkbox_index],
                               mar: params[:mar][checkbox_index],
                               apr: params[:apr][checkbox_index],
                               may: params[:may][checkbox_index],
                               jun: params[:jun][checkbox_index],
                               jul: params[:jul][checkbox_index],
                               aug: params[:aug][checkbox_index],
                               sep: params[:sep][checkbox_index],
                               oct: params[:oct][checkbox_index],
                               nov: params[:nov][checkbox_index],
                               dec: params[:dec][checkbox_index])
    return checkbox_index+=1
  end
end
