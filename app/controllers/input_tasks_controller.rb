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
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @input_task = InputTask.new(input_task_params)

      if @input_task.save
        flash[:notice] = "InputTask saved successfully"
        redirect_to input_tasks_path
      else
        flash[:notice] = "InputTask can't save"
        render 'new'
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
