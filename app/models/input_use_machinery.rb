class InputUseMachinery < ActiveRecord::Base
	include UuidHelper
	
	belongs_to :machinery
  	belongs_to :input_task
end
