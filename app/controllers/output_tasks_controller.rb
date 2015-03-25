class OutputTasksController < ApplicationController
  load_and_authorize_resource except: :create
  respond_to :html, :json

  add_breadcrumb "All Output Tasks", :output_tasks_path

  # has_scope :planting_project_id

  def index
    begin
      @output_task = OutputTask.new

      if params[:output_task] and params[:output_task][:name] and !params[:output_task][:name].nil?
        @output_tasks = OutputTask.find_by_name(params[:output_task][:name]).page(params[:page]).order('created_at DESC').per(session[:item_per_page])
      else
        @output_tasks = apply_scopes(OutputTask).page(params[:page]).order('created_at DESC').per(session[:item_per_page])
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
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @output_task = OutputTask.new(output_task_params)

      @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: @output_task.warehouse_id, material_uuid: @output_task.material_id)
      remaining_material_amount_in_stock = @warehouse_material_amount.amount

      @blocks = Block.find_by(uuid: @output_task.block_id)
      block_tree_amounts = @blocks.tree_amount

        # material_amount_in_stock must be greater than 0 and material_amount(input value) must be less than or equal to material_amount_in_stock
        if remaining_material_amount_in_stock > 0 and @output_task.material_amount <= remaining_material_amount_in_stock and @output_task.tree_amount > 0 and @output_task.tree_amount <= block_tree_amounts
          if @output_task.save
            remaining_amount = remaining_material_amount_in_stock - @output_task.material_amount

            @warehouse_material_amount.update_attributes!(amount: remaining_amount)

            flash[:notice] = "OutputTask saved successfully"
            redirect_to output_tasks_path
          else
            flash[:notice] = "OutputTask can't save"
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
    @output_task = OutputTask.find(params[:id])
  end

  private
  def output_task_params
    params.require(:output_task).permit(:name, :start_date, :end_date, :block_id, :planting_project, :tree_amount, :labor_id, :reference_number, :output_amount, :finish_production_id, :finish_warehouse_id, :finish_amount, :nursery_production_id, :nursery_warehouse_id, :nursery_amount, :spoiled_amount, :spoiled_note, :note, :created_by, :updated_by)
  end
end
