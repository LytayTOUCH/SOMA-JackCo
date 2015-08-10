class PlanProcessesController < ApplicationController
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
      
      if params[:exist_ip_1] == "true"
        params[:app_id_ip_1].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_ip_1][index],
                                     process_plan_category_id: "process-plan-category-ip-1-000000001",
                                     material_label: params[:material_label_ip_1][index],
                                     material_value: params[:material_value_ip_1][index])
        end
      end
      if params[:exist_ip_2] == "true"
        params[:app_id_ip_2].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_ip_2][index],
                                     process_plan_category_id: "process-plan-category-ip-2-000000002",
                                     material_label: params[:material_label_ip_2][index],
                                     material_value: params[:material_value_ip_2][index])
        end
      end
      if params[:exist_ip_3] == "true"
        params[:app_id_ip_3].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_ip_3][index],
                                     process_plan_category_id: "process-plan-category-ip-3-000000003",
                                     material_label: params[:material_label_ip_3][index],
                                     material_value: params[:material_value_ip_3][index])
        end
      end
      if params[:exist_ip_4] == "true"
        params[:app_id_ip_4].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_ip_4][index],
                                     process_plan_category_id: "process-plan-category-ip-4-000000004",
                                     material_label: params[:material_label_ip_4][index],
                                     material_value: params[:material_value_ip_4][index])
        end
      end
      if params[:exist_ip_5] == "true"
        params[:app_id_ip_5].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_ip_5][index],
                                     process_plan_category_id: "process-plan-category-ip-5-000000005",
                                     material_label: params[:material_label_ip_5][index],
                                     material_value: params[:material_value_ip_5][index])
        end
      end
      if params[:exist_ip_6] == "true"
        params[:app_id_ip_6].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_ip_6][index],
                                     process_plan_category_id: "process-plan-category-ip-6-000000006",
                                     material_label: params[:material_label_ip_6][index],
                                     material_value: params[:material_value_ip_6][index])
        end
      end
      if params[:exist_labor] == "true"
        params[:app_id_labor].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_labor][index],
                                     process_plan_category_id: "process-plan-category-labor-00000007",
                                     material_label: params[:material_label_labor][index],
                                     material_value: params[:material_value_labor][index])
        end
      end
      if params[:exist_machinery] == "true"
        params[:app_id_machinery].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_machinery][index],
                                     process_plan_category_id: "process-plan-category-machinery-0008",
                                     material_label: params[:material_label_machinery][index],
                                     material_value: params[:material_value_machinery][index])
        end
      end
      if params[:exist_other] == "true"
        params[:app_id_other].each_with_index do |app_id, index|
          ProcessPlanMaterial.create(process_plan_id: @process_plan.uuid,
                                     app_id: app_id,
                                     app_description_id: params[:app_description_id_other][index],
                                     process_plan_category_id: "process-plan-category-other-00000009",
                                     material_label: params[:material_label_other][index],
                                     material_value: params[:material_value_other][index])
        end
      end
      
      #Schedule
      params[:app_id_schedule].each_with_index do |app_id, index|
        
      end
      
      flash[:notice] = "Process & Implement Plan save successfully"
      redirect_to plan_processes_index_path+"?filter[year]="+params[:year]+"&filter[planting_project_id]="+params[:planting_project_id]
    else
      flash[:notice] = "Process & Implement Plan can't be saved."
      redirect_to plan_processes_new_path+"?year="+params[:year]+"&planting_project_id="+params[:planting_project_id]
    end
  end
end
