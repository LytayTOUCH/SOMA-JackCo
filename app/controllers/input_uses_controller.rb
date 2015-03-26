class InputUsesController < ApplicationController
  def index
  	@input_tasks = InputTask.where("start_date = ? AND end_date = ?", params[:start_date], params[:end_date])

  end
end
