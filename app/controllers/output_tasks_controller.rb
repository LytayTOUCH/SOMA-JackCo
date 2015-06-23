class OutputTasksController < ApplicationController
  load_and_authorize_resource except: [:create, :get_zones_by_farm, :get_areas_by_zone, :get_blocks_by_area, :get_distributions_by_planting_project, :get_application_data]
  respond_to :html, :json

  add_breadcrumb "All Output Tasks", :output_tasks_path

  has_scope :planting_project_id

  def index
    @output_tasks = apply_scopes(OutputTask).order(created_at: :desc)
  end

  def new
    if params[:id].nil? || params[:id]==""
      @output_task = OutputTask.new
    else
      output_task = OutputTask.find_by_uuid(params[:id])
      @output_task = OutputTask.new
      
      @output_task.name = output_task.name
      @output_task.start_date = output_task.start_date
      @output_task.end_date = output_task.end_date
      @output_task.block_id = output_task.block_id
      @output_task.planting_project_id = output_task.planting_project_id
      @output_task.tree_amount = output_task.tree_amount
      @output_task.labor_id = output_task.labor_id
      @output_task.reference_number = output_task.reference_number
      @output_task.note = output_task.note
      @output_task.farm_id = output_task.farm_id
      @output_task.zone_id = output_task.zone_id
      @output_task.area_id = output_task.area_id
    end
  end

  def new_output_task_from_map
    @output_task = OutputTask.new
    @block = Block.find_by(uuid: params[:block_id])
    @farm_block = @block.farm.name
    @planting_project = PlantingProject.find_by(uuid: @block.planting_project_id)
    
    @productions = Production.where(planting_project_id: @block.planting_project_id)
    @warehouses = Warehouse.all
  end

  def create
    begin
      @output_task = OutputTask.new(output_task_params)
      output_task_end_date = @output_task.end_date

      if @output_task.save
        create_log current_user.uuid, "Created New Output Task", @output_task
        
        # Start Select Equipment
        if params[:equipments].present?               
          @equipment_ids = params[:equipments]
          @equipment_ids.split(",").each do |equipment_id|
            unless equipment_id.empty?
              OutputUseEquipment.create(output_id: @output_task.uuid, equipment_id: equipment_id)
            end
          end
        end
        #End Select Equipment
        
        index = 0
        @warehouses = params[:warehouses]
        @materials = params[:materials]
        @qty = params[:material_qtys]

        # START -- DISTRIBUTION SECTION
        dis_index = 0
        params[:distribution_amounts].each do |amount|
          OutputDistribution.create(output_task_id: @output_task.uuid, distribution_id: params[:distribution_ids][dis_index], unit_measure_id: params[:uom_ids][dis_index], amount: amount == "" ? "0":amount)
          dis_index += 1
        end
        # END -- DISTRIBUTION SECTION
         
        flash[:notice] = "Output Task saved successfully"
        redirect_to new_output_task_path+"/?id="+@output_task.uuid
      else
        flash[:notice] = "Output Task can't save"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def show
    @output_task = OutputTask.find(params[:id])
    @output_use_equipments = OutputUseEquipment.where(output_id: params[:id])
  end
  
  def get_zones_by_farm
    render json: Zone.where(farm_id: params[:farm_id])
  end
  
  def get_areas_by_zone
    render json: Area.where(zone_id: params[:zone_id])
  end
  
  def get_blocks_by_area
    render json: Block.where(area_id: params[:area_id])
  end
  
  def get_distributions_by_planting_project
    render json: Distribution.where(planting_project_id: params[:planting_project_id]).order("order_of_display ASC")
  end
  
  def get_application_data
    render json: App.where("planting_project_id = ? AND app_type = ?", params[:planting_project_id], "OUTPUT")
  end

  def add_new_labor
    begin
      @labor = Labor.new
    rescue Exception => e
      puts e
    end
  end

  def save_new_labor
    @labor = Labor.new(labor_params)
    # manager_uuid has no default value, Error !
    @labor.manager_uuid = ""
    @labor if @labor.save
  end

  private
  def output_task_params
    params.require(:output_task).permit(:name, :start_date, :end_date, :block_id, :planting_project_id, :tree_amount, :labor_id, :reference_number, :note, :created_by, :updated_by, :farm_id, :zone_id, :area_id)
  end
  def labor_params
    params.require(:labor).permit(:name, :position_id, :gender)
  end
end
