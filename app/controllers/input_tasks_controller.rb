class InputTasksController < ApplicationController
	load_and_authorize_resource except: [:create, :get_application_data]

	add_breadcrumb "All InputTasks", :input_tasks_path

  has_scope :planting_project_id

  def index
    @input_tasks = apply_scopes(InputTask).order('updated_at DESC')
  end

  def new
    begin
      if params[:id].nil? || params[:id]==""
        @input_task = InputTask.new
      else
        input_task = InputTask.find_by_uuid(params[:id])
        @input_task = InputTask.new
        
        @input_task.name = input_task.name
        @input_task.start_date = input_task.start_date
        @input_task.end_date = input_task.end_date
        @input_task.block_id = input_task.block_id
        @input_task.tree_amount = input_task.tree_amount
        @input_task.labor_id = input_task.labor_id
        @input_task.reference_number = input_task.reference_number
        @input_task.note = input_task.note
        @input_task.planting_project_id = input_task.planting_project_id
        @input_task.farm_id = input_task.farm_id
        @input_task.zone_id = input_task.zone_id
        @input_task.area_id = input_task.area_id
      end
      
      @materials = Material.select("uuid, name")

    rescue Exception => e
      puts e
    end
  end
  
  def edit
    @input_task = InputTask.find(params[:id])
    @materials = Material.select("uuid, name")
    add_breadcrumb App.find_by_uuid(@input_task.name).nil? ? @input_task.name : App.find_by_uuid(@input_task.name).name, :edit_input_task_path
  end
  
  def update
    @input_task = InputTask.find(params[:id])
    old_month = @input_task.start_date.month
    old_year = @input_task.start_date.year
    old_materials = @input_task.input_use_materials
    old_machineries = @input_task.input_use_machineries
    
    if @input_task.update_attributes(input_task_params)
      create_log current_user.uuid, "Update Input Task", @input_task
# _________________________________________________________________________________
      
# =============================== START : EQUIPMENT ===============================
      # Remove all of the previous InputUseEquipment objects from the DB,
      InputUseEquipment.delete_all(input_id: @input_task.uuid)
      
      # before create new ones.
      if params[:equipments].present?
        params[:equipments].split(",").each do |equipment_id|
          unless equipment_id.empty?
            InputUseEquipment.create(input_id: @input_task.uuid, equipment_id: equipment_id)
          end
        end
      end
# ================================ END : EQUIPMENT ================================
      
# _________________________________________________________________________________
      
# =============================== START : MACHINERY ===============================
      
      # Remove old machinery's material from stock_balance
      old_machineries.each do |input_use_machinery|
        sb = StockBalance.find_by(:material_id => input_use_machinery.material_id, :warehouse_id => input_use_machinery.warehouse_id, :month => old_month, :year => old_year)
        unless sb.nil?
          stock_out = sb.stock_out - input_use_machinery.material_amount #Instead of increase(+) the amount of stock out, we decrease(-) it.
          # and everything is the same from here on...
          ending_balance = sb.beginning_balance + sb.stock_in - stock_out
          
          unless sb.adjusted_ending_balance.nil?
            diff_balance = sb.adjusted_ending_balance - sb.ending_balance
            new_adjusted_ending_balance = ending_balance + diff_balance
            
            sb.update(stock_out: stock_out, ending_balance: ending_balance, adjusted_ending_balance: new_adjusted_ending_balance)
          else
            sb.update(stock_out: stock_out, ending_balance: ending_balance)
          end
        end
      end
      
      # Remove all of the previous InputUseMachinery objects from the DB,
      InputUseMachinery.delete_all(input_id: @input_task.uuid)
      
      # before create new ones.
      if params[:machineries].present?
        @machinery_ids = params[:machinery_id]
        @warehouses_of_machinery = params[:warehouses_of_machinery]
        @materials_of_machinery = params[:materials_of_machinery]
        @qty_of_machinery = params[:material_qtys_of_machinery]
        
        @machinery_ids.each_with_index do |machinery_id, index|
          unless machinery_id.empty?
            warehouse = @warehouses_of_machinery[index]
            material = @materials_of_machinery[index]
            qty = @qty_of_machinery[index]

            @machinery = Machinery.find_by_uuid(machinery_id)
            @machinery.update_attributes!(availabe_date: @input_task.end_date)
            InputUseMachinery.create(input_id: @input_task.uuid, machinery_id: machinery_id, warehouse_id: warehouse, material_id: material, material_amount: qty.to_f)
            
            # START - STOCK BALANCE
            month = @input_task.start_date.month
            year = @input_task.start_date.year
            sb = StockBalance.find_by(:material_id => material, :warehouse_id => warehouse, :month => month, :year => year)
            unless sb.nil?
              stock_out = sb.stock_out + qty.to_f #Increase(+) the amount of stock out
              ending_balance = sb.beginning_balance + sb.stock_in - stock_out
              
              unless sb.adjusted_ending_balance.nil?
                diff_balance = sb.adjusted_ending_balance - sb.ending_balance
                new_adjusted_ending_balance = ending_balance + diff_balance
                
                sb.update(stock_out: stock_out, ending_balance: ending_balance, adjusted_ending_balance: new_adjusted_ending_balance)
              else
                sb.update(stock_out: stock_out, ending_balance: ending_balance)
              end
            end
            # END - STOCK BALANCE
          end
        end
      end
# ================================ END : MACHINERY ================================
      
# _________________________________________________________________________________
      
# ================================ START : MATERIAL ===============================
      
      # Remove old materials' amount from stock_balance
      old_materials.each do |input_use_material|
        sb = StockBalance.find_by(:material_id => input_use_material.material_id, :warehouse_id => input_use_material.warehouse_id, :month => old_month, :year => old_year)
        unless sb.nil?
          stock_out = sb.stock_out - input_use_material.material_amount #Instead of increase(+) the amount of stock out, we decrease(-) it.
          # and everything is the same from here on...
          ending_balance = sb.beginning_balance + sb.stock_in - stock_out
          
          unless sb.adjusted_ending_balance.nil?
            diff_balance = sb.adjusted_ending_balance - sb.ending_balance
            new_adjusted_ending_balance = ending_balance + diff_balance
            
            sb.update(stock_out: stock_out, ending_balance: ending_balance, adjusted_ending_balance: new_adjusted_ending_balance)
          else
            sb.update(stock_out: stock_out, ending_balance: ending_balance)
          end
        end
      end
      
      # Remove all of the previous InputUseMaterial objects from the DB,
      InputUseMaterial.delete_all(input_id: @input_task.uuid)
      
      # before create new ones.
      if params[:materials].present?
        @material_ids = params[:material_id]
        @warehouses_of_material = params[:warehouses_of_material]
        @qty_of_material = params[:material_qtys_of_material]
        
        @material_ids.each_with_index do |material_id,indexs|
          unless material_id.empty?
            warehouse_of_material = @warehouses_of_material[indexs]
            qty_of_material = @qty_of_material[indexs]

            InputUseMaterial.create(input_id: @input_task.uuid, material_id: material_id, warehouse_id: warehouse_of_material, material_amount: qty_of_material.to_f)
            
            # START - STOCK BALANCE
            month = @input_task.start_date.month
            year = @input_task.start_date.year
            sb = StockBalance.find_by(:material_id => material_id, :warehouse_id => warehouse_of_material, :month => month, :year => year)
            unless sb.nil?
              stock_out = sb.stock_out + qty_of_material.to_f  #Increase(+) the amount of stock out
              ending_balance = sb.beginning_balance + sb.stock_in - stock_out
              
              unless sb.adjusted_ending_balance.nil?
                diff_balance = sb.adjusted_ending_balance - sb.ending_balance
                new_adjusted_ending_balance = ending_balance + diff_balance
                
                sb.update(stock_out: stock_out, ending_balance: ending_balance, adjusted_ending_balance: new_adjusted_ending_balance)
              else
                sb.update(stock_out: stock_out, ending_balance: ending_balance)
              end
            end
            # END - STOCK BALANCE
          end
        end
      end
# ================================= END : MATERIAL ================================
      
      flash[:notice] = "Input Task updated successfully"
      redirect_to input_task_path(@input_task)
    else
      flash[:notice] = "Input Task can't be saved"
      render "edit"
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

      # START - MATERIAL 
      if params[:materials].present?              
        @material_ids = params[:material_id]
        @warehouses_of_material = params[:warehouses_of_material]
        @qty_of_material = params[:material_qtys_of_material]
        indexs = 0

        @material_ids.each do |material_id|
          unless material_id.empty?
            warehouse_of_material = @warehouses_of_material[indexs]
            qty_of_material = @qty_of_material[indexs]
            indexs += 1

            if @input_task.save
              create_log current_user.uuid, "Created New Input Task", @input_task
              
              # START - INPUT USE MATERIALS
              InputUseMaterial.create(input_id: @input_task.uuid, material_id: material_id, warehouse_id: warehouse_of_material, material_amount: qty_of_material.to_f)
              # END - INPUT USE MATERIALS
              
              # START - STOCK BALANCE
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
              # END - STOCK BALANCE
            else
              flash[:notice] = "Input Task can't be saved"
              render 'new'
            end
          end
        end
      else
        flash[:notice] = "Material is required"
        render 'new'
      end
      # END - MATERIAL
      
      # START - MACHINERY
      if params[:machineries].present?
        @machinery_ids = params[:machinery_id]
        @warehouses_of_machinery = params[:warehouses_of_machinery]
        @materials_of_machinery = params[:materials_of_machinery]
        @qty_of_machinery = params[:material_qtys_of_machinery]
        
        index = 0
        @machinery_ids.each do |machinery_id|
          unless machinery_id.empty?
            warehouse = @warehouses_of_machinery[index]
            material = @materials_of_machinery[index]
            qty = @qty_of_machinery[index]
            index += 1

            @machinery = Machinery.find_by_uuid(machinery_id)
            @machinery.update_attributes!(availabe_date: input_task_end_date)
            InputUseMachinery.create(input_id: @input_task.uuid, machinery_id: machinery_id, warehouse_id: warehouse, material_id: material, material_amount: qty.to_f)
            
            # START - STOCK BALANCE
            month = @input_task.start_date.month
            year = @input_task.start_date.year
            sb = StockBalance.find_by(:material_id => material, :warehouse_id => warehouse, :month => month, :year => year)
            unless sb.nil?
              stock_out = sb.stock_out + qty.to_f
              ending_balance = sb.beginning_balance + sb.stock_in - stock_out
              
              unless sb.adjusted_ending_balance.nil?
                diff_balance = sb.adjusted_ending_balance - sb.ending_balance
                new_adjusted_ending_balance = ending_balance + diff_balance
                
                sb.update(stock_out: stock_out, ending_balance: ending_balance, adjusted_ending_balance: new_adjusted_ending_balance)
              else
                sb.update(stock_out: stock_out, ending_balance: ending_balance)
              end
            end
            # END - STOCK BALANCE
          end
        end
      end
      # END - MACHINERY
      
      # START - EQUIPMENT
      if params[:equipments].present?
        @equipment_ids = params[:equipments]
        @equipment_ids.split(",").each do |equipment_id|
          unless equipment_id.empty?
            InputUseEquipment.create(input_id: @input_task.uuid, equipment_id: equipment_id)
          end
        end
      end
      #END - EQUIPMENT

      flash[:notice] = "Input Task saved successfully"
      redirect_to new_input_task_path+"/?id="+@input_task.uuid

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
    params.require(:input_task).permit(:name, :start_date, :end_date, :farm_id, :zone_id, :area_id, :block_id, :planting_project_id, :tree_amount, :labor_id, :reference_number, :note, :created_by, :updated_by)
  end
  def labor_params
    params.require(:labor).permit(:name, :position_id, :gender)
  end

end
