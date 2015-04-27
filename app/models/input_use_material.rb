class InputUseMaterial < ActiveRecord::Base
  include UuidHelper

  belongs_to :material
  belongs_to :input_task
end