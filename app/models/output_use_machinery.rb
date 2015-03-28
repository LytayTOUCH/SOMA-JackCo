class OutputUseMachinery < ActiveRecord::Base
  include UuidHelper

  belongs_to :machinery
  belongs_to :output_task
end
