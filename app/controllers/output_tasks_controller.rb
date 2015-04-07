class OutputTasksController < ApplicationController
  load_and_authorize_resource except: :create
  respond_to :html, :json

  add_breadcrumb "All Output Tasks", :output_tasks_path

  # has_scope :planting_project_id

  def index
    begin
      @output_task = OutputTask.new

      if params[:output_task] and params[:output_task][:name] and !params[:output_task][:name].nil?
        @output_tasks = OutputTask.find_by_output_task_name(params[:output_task][:name]).page(params[:page]).order('created_at DESC').per(session[:item_per_page])
      else
        @output_tasks = OutputTask.page(params[:page]).order('created_at DESC').per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @output_task = OutputTask.new
      @blocks = Block.all
      @farms_name = Block.select("uuid, name, farm_id")
      @planting_project_names = Production.select("uuid, status, planting_project_id")
      
      @finish_warehouse_type = WarehouseType.find_by_name("Finished Goods Warehouse")
      @nursery_warehouse_type = WarehouseType.find_by_name("Nursery Warehouse")
      @finish_warehouses = Warehouse.where(warehouse_type_uuid: @finish_warehouse_type)
      @nursery_warehouses = Warehouse.where(warehouse_type_uuid: @nursery_warehouse_type)
      @warehouses = Warehouse.all
      @machineries = Machinery.select("uuid, name")

    rescue Exception => e
      puts e
    end
  end

  def new_output_task_from_map
    @output_task = OutputTask.new
    @block = Block.find_by(uuid: params[:block_id])
    @farm_block = @block.farm.name
    @planting_project = PlantingProject.find_by(uuid: @block.planting_project_id)
    
    @finish_warehouse_type = WarehouseType.find_by_name("Finished Goods Warehouse")
    @nursery_warehouse_type = WarehouseType.find_by_name("Nursery Warehouse")
    @finish_warehouses = Warehouse.where(warehouse_type_uuid: @finish_warehouse_type)
    @nursery_warehouses = Warehouse.where(warehouse_type_uuid: @nursery_warehouse_type)
    @productions = Production.where(planting_project_id: @block.planting_project_id)
    @warehouses = Warehouse.all
    @machineries = Machinery.select("uuid, name")
  end

  def create
    begin
      @output_task = OutputTask.new(output_task_params)
      output_task_end_date = @output_task.end_date.to_s

      puts "====================****========================"
      puts "finish_production_id = " + @finish_production_id = @output_task.finish_production_id
      puts "nursery_production_id = " + @nursery_production_id = @output_task.nursery_production_id
      puts "finish_warehouse_id = " + @finish_warehouse_id = @output_task.finish_warehouse_id
      puts "nursery_warehouse_id = " + @nursery_warehouse_id = @output_task.nursery_warehouse_id
      puts "Output Task End Date = " + output_task_end_date
      puts "====================****========================"

      @finish_production_id = @output_task.finish_production_id
      @nursery_production_id = @output_task.nursery_production_id
      @finish_warehouse_id = @output_task.finish_warehouse_id
      @nursery_warehouse_id = @output_task.nursery_warehouse_id

      @finish_warehouse_amount = WarehouseProductionAmount.find_by(warehouse_id: @finish_warehouse_id, production_id: @finish_production_id)
      @nursery_warehouse_amount = WarehouseProductionAmount.find_by(warehouse_id: @nursery_warehouse_id, production_id: @nursery_production_id)
      
      total_output_amount = @output_task.output_amount
      finish_amount = @output_task.finish_amount
      nursery_amount = @output_task.nursery_amount
      spoiled_amount = @output_task.spoiled_amount
      sum_finish_nursery_spoil = finish_amount + nursery_amount + spoiled_amount
      output_task_end_date = @output_task.end_date

      if total_output_amount >= sum_finish_nursery_spoil
        finish_warehouse_amount = @finish_warehouse_amount.amount
        finish_warehouse_amount += finish_amount

        nursery_warehouse_amount = @nursery_warehouse_amount.amount
        nursery_warehouse_amount += nursery_amount

        if @output_task.save
          @finish_warehouse_amount.update_attributes!(amount: finish_warehouse_amount)
          @nursery_warehouse_amount.update_attributes!(amount: nursery_warehouse_amount)

          puts "=====================Machinery IDs========================"    
          @machinery_ids = params[:machineries]
          @machinery_ids.split(",").each do |machinery_id|
            puts "=====================Machinery========================"      
            @machinery = Machinery.find_by_uuid(machinery_id)
            # @machinery.availabe_date = output_task_end_date
            @machinery.update_attributes!(availabe_date: output_task_end_date)
            OutputUseMachinery.create(output_id: @output_task.uuid, machinery_id: machinery_id)
          end
          
          flash[:notice] = "OutputTask saved successfully"
          redirect_to output_tasks_path
        else
          flash[:notice] = "OutputTask can't save"
          render 'new'
        end
      else
        flash[:notice] = "Finish, nursery, and spoiled quantity exceeds the total output task quantity. Please check the three quantities."  
        render 'new'
      end  
    rescue Exception => e
      puts e
    end
  end

  def show
    @output_task = OutputTask.find(params[:id])
    @finish_production = Production.find_by_uuid(@output_task.finish_production_id) 
    @nursery_production = Production.find_by_uuid(@output_task.nursery_production_id) 
  end

  private
  def output_task_params
    params.require(:output_task).permit(:name, :start_date, :end_date, :block_id, :planting_project_id, :tree_amount, :labor_id, :reference_number, :output_amount, :finish_production_id, :finish_warehouse_id, :finish_amount, :nursery_production_id, :nursery_warehouse_id, :nursery_amount, :spoiled_amount, :spoiled_note, :note, :created_by, :updated_by)
  end
end
