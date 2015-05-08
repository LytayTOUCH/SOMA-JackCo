class InputUseEquipment < ActiveRecord::Base
	include UuidHelper

	belongs_to :equipment
  	belongs_to :input_task
end
