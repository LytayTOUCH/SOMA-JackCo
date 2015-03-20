class InputTasksController < ApplicationController
	load_and_authorize_resource except: :create

	add_breadcrumb "All InputTasks", :input_tasks_path

  def index
  	begin
      @input_task = InputTask.new

      if params[:input_task] and params[:input_task][:name] and !params[:input_task][:name].nil?
        @input_tasks = InputTask.find_by_name(params[:input_task][:name]).page(params[:page]).per(5)
      else
        @input_tasks = InputTask.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @input_task = InputTask.new

      project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
      
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ?", project_uuid, true)

    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @input_task = InputTask.new(input_task_params)

      @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: @input_task.warehouse_id, material_uuid: @input_task.material_id)

      	remaining_material_amount_in_stock = @warehouse_material_amount.amount

      	# material_amount_in_stock must be greater than 0 and material_amount(input value) must be less than or equal to material_amount_in_stock
      	if remaining_material_amount_in_stock > 0 and @input_task.material_amount <= remaining_material_amount_in_stock

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
      		flash[:notice] = "Requested quantity exceeds stock quantity or remaining quantity. Please import stock in first"  
        	redirect_to :back
        	# render 'new'
      	end

    rescue Exception => e
      puts e
    end
  end

  private
  def input_task_params
    params.require(:input_task).permit(:name, :start_date, :end_date, :block_id, :tree_amount, :labor_id, :reference_number, :warehouse_id, :material_id, :material_amount, :note, :created_by)
  end

end
