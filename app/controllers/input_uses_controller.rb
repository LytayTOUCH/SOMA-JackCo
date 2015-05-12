class InputUsesController < ApplicationController
  has_scope :start_date, :using => [:started_at, :ended_at] , :type => :hash

  def index

    # binding.pry
    
    @input_tasks = apply_scopes(InputTask).all

    @material_category = MaterialCategory.all

    @blocks = Block.group(:area)

  end
end