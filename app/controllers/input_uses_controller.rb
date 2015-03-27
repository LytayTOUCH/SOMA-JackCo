class InputUsesController < ApplicationController
  def index
  	@input_tasks = InputTask.where("start_date = ? AND end_date = ?", params[:start_date], params[:end_date])

  	@input_tasks.each do |in_task|
  		@start_date = in_task.start_date
  		@end_date = in_task.end_date
  	end

  	@material_category = MaterialCategory.all

  end
end
