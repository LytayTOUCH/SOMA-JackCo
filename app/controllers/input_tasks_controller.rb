class InputTasksController < ApplicationController
	load_and_authorize_resource except: [:create, :get_application_data]

	add_breadcrumb "All InputTasks", :input_tasks_path

  has_scope :planting_project_id

  def index
    @input_tasks = apply_scopes(InputTask).order('updated_at DESC')
  end

  def new
    begin
      @input_task = InputTask.new
      @materials = Material.select("uuid, name")

    rescue Exception => e
      puts e
    end
  end

  def new_input_task_from_map
    @input_task = InputTask.new
    project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
    @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ?", project_uuid, true)
    @block = Block.find_by(uuid: params[:block_id])
    @farm_block = @block.farm.name
  end

  def create
    begin
      @input_task = InputTask.new(input_task_params)
      input_task_end_date = @input_task.end_date
      @materials = Material.select("uuid, name")

        # Start Select Material 
        if params[:materials].present?              
          @material_ids = params[:materials]
          @warehouses_of_material = params[:warehouses_of_material]
          @qty_of_material = params[:material_qtys_of_material]
          indexs = 0

          @material_ids.split(",").each do |material_id|
            unless material_id.empty?
              warehouse_of_material = @warehouses_of_material[indexs]
              qty_of_material = @qty_of_material[indexs]
              indexs += 1

              if warehouse_of_material.present?
                @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: warehouse_of_material, material_uuid: material_id)
                total_in_stock = @warehouse_material_amount.amount
                remain_in_stock = total_in_stock - qty_of_material.to_f
                
                if total_in_stock >= qty_of_material.to_f

                  if @input_task.save

                    create_log current_user.uuid, "Created New Input Task", @input_task

                    InputUseMaterial.create(input_id: @input_task.uuid, material_id: material_id, warehouse_id: warehouse_of_material, material_amount: qty_of_material.to_f)
                    @warehouse_material_amount.update_attributes!(amount: remain_in_stock)
                    
                    # STOCK BALANCE
                    month = @input_task.start_date.month
                    year = @input_task.start_date.year
                    sb = StockBalance.find_by(:material_id => material_id, :warehouse_id => warehouse_of_material, :month => month, :year => year)
                    unless sb.nil?
                      stock_out = sb.stock_out + qty_of_material.to_f
                      ending_balance = sb.beginning_balance + sb.stock_in - stock_out
                      
                      unless sb.adjusted_ending_balance.nil?
                        diff_balance = sb.adjusted_ending_balance - sb.ending_balance
                        new_adjusted_ending_balance = ending_balance + diff_balance
                        
                        sb.update(stock_out: stock_out, ending_balance: ending_balance, adjusted_ending_balance: new_adjusted_ending_balance)
                      else
                        sb.update(stock_out: stock_out, ending_balance: ending_balance)
                      end
                    end

                  else
                    flash[:notice] = "Input Task can't be saved"
                    render 'new'
                  end

                
                else
                  flash[:notice] = "Suggested quantity exceeds the stock quantity"
                  render 'new' 
                end
              else
                flash[:notice] = "Make sure warehouse of material is selected!"
                render 'new'
              end
  
            end
          end
        else
          flash[:notice] = "Material is required"
          render 'new'
        end
        #End Select Material

        # Start Select Equipment
        if params[:equipments].present?               
          @equipment_ids = params[:equipments]
          index_equipment = 0

          @equipment_ids.split(",").each do |equipment_id|
            unless equipment_id.empty?
              index_equipment += 1

                InputUseEquipment.create(input_id: @input_task.uuid, equipment_id: equipment_id)             
               
            end
          end
        else
        end
        #End Select Equipment

        # Start Select Machinery               
        @machinery_ids = params[:machineries]
        @warehouses_of_machinery = params[:warehouses_of_machinery]
        @materials_of_machinery = params[:materials_of_machinery]
        @qty_of_machinery = params[:material_qtys_of_machinery]
        index = 0
        
        if params[:machineries].present?
          @machinery_ids.split(",").each do |machinery_id|
            unless machinery_id.empty?
              warehouse = @warehouses_of_machinery[index]
              material = @materials_of_machinery[index]
              qty = @qty_of_machinery[index]
              index += 1

              # Make sure Warehouse and Material of each machineries are selected
              if material.present? 
                @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: warehouse, material_uuid: material)
                
                total_in_stock = @warehouse_material_amount.amount
                remain_in_stock = total_in_stock - qty.to_f
                @machinery = Machinery.find_by_uuid(machinery_id)
                
                if total_in_stock >= qty.to_f

                    @machinery.update_attributes!(availabe_date: input_task_end_date)
                    InputUseMachinery.create(input_id: @input_task.uuid, machinery_id: machinery_id, warehouse_id: warehouse, material_id: material, material_amount: qty.to_f)
                    @warehouse_material_amount.update_attributes!(amount: remain_in_stock)             
                
                else
                  flash[:notice] = "Suggested quantity exceeds the stock quantity"
                  render 'new' 
                end
              # else
              #   flash[:notice] = "Make sure warehouse and material are selected!"
              #   render 'new'
              end

            end

          end

        else
        end
        #End Select Machinery

      flash[:notice] = "Input Task saved successfully"
      redirect_to input_tasks_path   

    rescue Exception => e
      puts e
    end
  end

  def show
    @input_task = InputTask.find(params[:id])
    @input_use_equipments = InputUseEquipment.where(input_id: params[:id])
    @input_use_machineries = InputUseMachinery.where(input_id: params[:id])
    @input_use_materials = InputUseMaterial.where(input_id: params[:id])

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
  
  def get_application_data
    render json: App.where("planting_project_id = ? AND app_type = ?", params[:planting_project_id], "INPUT")
  end

  private
  def input_task_params
    params.require(:input_task).permit(:name, :start_date, :end_date, :farm_id, :zone_id, :area_id, :block_id, :planting_project_id, :tree_amount, :labor_id, :reference_number, :note, :created_by)
  end
  def labor_params
    params.require(:labor).permit(:name, :position_id, :gender)
  end

end
