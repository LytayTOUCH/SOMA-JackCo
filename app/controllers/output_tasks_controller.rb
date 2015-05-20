class OutputTasksController < ApplicationController
  load_and_authorize_resource except: :create
  respond_to :html, :json

  add_breadcrumb "All Output Tasks", :output_tasks_path

  def index
    @output_tasks = OutputTask.order(created_at: :desc)
  end

  def new
    @output_task = OutputTask.new
    if !params[:output_task].nil?
      if !params[:output_task][:farm_id].nil? && params[:output_task][:farm_id] != "" 
        @output_task.farm_id = params[:output_task][:farm_id]
      end
      if !params[:output_task][:zone_id].nil? && params[:output_task][:zone_id] != ""
        @output_task.zone_id = params[:output_task][:zone_id]
      end
      if !params[:output_task][:area_id].nil? && params[:output_task][:area_id] != ""
        @output_task.area_id = params[:output_task][:area_id]
      end
      if !params[:output_task][:block_id].nil? && params[:output_task][:block_id] != ""
        @output_task.block_id = params[:output_task][:block_id]
      end
      if !params[:output_task][:planting_project_id].nil?
        @output_task.planting_project_id = params[:output_task][:planting_project_id]
      end
    end
  end

  def new_output_task_from_map
    @output_task = OutputTask.new
    @block = Block.find_by(uuid: params[:block_id])
    @farm_block = @block.farm.name
    @planting_project = PlantingProject.find_by(uuid: @block.planting_project_id)
    
    @productions = Production.where(planting_project_id: @block.planting_project_id)
    @warehouses = Warehouse.all
    @machineries = Machinery.select("uuid, name").where("planting_project_id = ? and status = ? and availabe_date < ?", @planting_project.uuid, true, Date.today).distinct(:name)
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

        if params[:output_task][:machineries].is_a?(Array)
          params[:output_task][:machineries].each do |machinery_id|
            unless machinery_id.empty?
              puts "================= Output task UUID =============="
              puts @output_task.uuid
              puts "================= Warehouse '" + index.to_s + "'==========="
              warehouse = @warehouses[index]
              puts "================= Materials '" + index.to_s + "'==========="
              material = @materials[index]
              puts "================= Quantity '" + index.to_s + "'==========="
              qty = @qty[index]
              puts "============================================"
              index += 1

              @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: warehouse, material_uuid: material)
              puts "====================== Amount =========================="
              total_in_stock = @warehouse_material_amount.amount
              
              if total_in_stock > qty.to_f
                puts "============ Remain In Stock ============"
                remain_in_stock = total_in_stock - qty.to_f
                puts "========================================="
                @machinery = Machinery.find_by_uuid(machinery_id)
                @machinery.update_attributes!(availabe_date: output_task_end_date)
                OutputUseMachinery.create(output_id: @output_task.uuid, machinery_id: machinery_id, warehouse_id: warehouse, material_id: material, material_amount: qty.to_f)
                @warehouse_material_amount.update_attributes!(amount: remain_in_stock)
              else
                flash[:notice] = "Suggested quantity exceeds the stock quantity"
                render 'new' 
              end
            end
          end
        else
          @machinery_ids = params[:machineries]
          index = 0
          @machinery_ids.split(",").each do |machinery_id|
            unless machinery_id.empty?
              puts "================= Output task UUID =============="
              puts @output_task.uuid
              puts "================= Warehouse " + index.to_s + "==========="
              warehouse = @warehouses[index]
              puts "================= Materials " + index.to_s + "==========="
              material = @materials[index]
              puts "================= Quantity " + index.to_s + "==========="
              qty = @qty[index]
              puts "============================================"
              index += 1

              @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: warehouse, material_uuid: material)
              puts "====================== Amount =========================="
              total_in_stock = @warehouse_material_amount.amount
              
              if total_in_stock > qty.to_f
                puts "============ Remain In Stock ============"
                remain_in_stock = total_in_stock - qty.to_f
                puts "========================================="
                @machinery = Machinery.find_by_uuid(machinery_id)
                @machinery.update_attributes!(availabe_date: output_task_end_date)
                OutputUseMachinery.create(output_id: @output_task.uuid, machinery_id: machinery_id, warehouse_id: warehouse, material_id: material, material_amount: qty.to_f)
                @warehouse_material_amount.update_attributes!(amount: remain_in_stock)
              else
                flash[:notice] = "Suggested quantity exceeds the stock quantity"
                render 'new' 
              end  
            end
          end
        end
        
        # START -- DISTRIBUTION SECTION
        dis_index = 0
        params[:distribution_amounts].each do |amount|
          OutputDistribution.create(output_task_id: @output_task.uuid, distribution_id: params[:distribution_ids][dis_index], unit_measure_id: params[:uom_ids][dis_index], amount: amount == "" ? "0":amount)
          dis_index += 1
        end
        # END -- DISTRIBUTION SECTION
         
        flash[:notice] = "Output Task saved successfully"
        redirect_to output_tasks_path
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
    @output_use_machineries = OutputUseMachinery.where(output_id: params[:id])
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

  private
  def output_task_params
    params.require(:output_task).permit(:name, :start_date, :end_date, :block_id, :planting_project_id, :tree_amount, :labor_id, :reference_number, :note, :created_by, :updated_by, :farm_id, :zone_id, :area_id)
  end
end
