class InputTasksController < ApplicationController
	load_and_authorize_resource except: :create

	add_breadcrumb "All InputTasks", :input_tasks_path

  has_scope :planting_project_id

  def index
    @input_tasks = InputTask.order('updated_at DESC')
  end

  def new
    begin
      @input_task = InputTask.new
      project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ?", project_uuid, true)
      @farms_name = Block.select("uuid, name, farm_id")
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

      @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: @input_task.warehouse_id, material_uuid: @input_task.material_id)
      remaining_material_amount_in_stock = @warehouse_material_amount.amount

      @blocks = Block.find_by(uuid: @input_task.block_id)
      block_tree_amounts = @blocks.tree_amount

      	# material_amount_in_stock must be greater than 0 and material_amount(input value) must be less than or equal to material_amount_in_stock
      	if remaining_material_amount_in_stock > 0 and @input_task.material_amount <= remaining_material_amount_in_stock and @input_task.tree_amount > 0 and @input_task.tree_amount <= block_tree_amounts
      		if @input_task.save
      			remaining_amount = remaining_material_amount_in_stock - @input_task.material_amount

      			@warehouse_material_amount.update_attributes!(amount: remaining_amount)

        		flash[:notice] = "InputTask saved successfully"
        		redirect_to input_tasks_path
      		else
        		flash[:notice] = "InputTask can't save"
        		render 'new'
      		end

      	else
      		flash[:notice] = "Requested quantity exceeds stock quantity or remaining quantity. Please import stock in first."  
        	redirect_to :back
        	# render 'new'
      	end

    rescue Exception => e
      puts e
    end
  end

  def show
    @input_task = InputTask.find(params[:id])
  end

  private
  def input_task_params
    params.require(:input_task).permit(:name, :start_date, :end_date, :block_id, :tree_amount, :labor_id, :machinery_id, :reference_number, :warehouse_id, :material_id, :material_amount, :note, :created_by)
  end

end
