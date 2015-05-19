class OutputUseEquipment < ActiveRecord::Base
  include UuidHelper

  belongs_to :equipment
  belongs_to :output_task
end
