class OutputDistribution < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :output_task, foreign_key: :output_task_id
  belongs_to :distribution, foreign_key: :distribution_id
  belongs_to :unit_of_measurement, foreign_key: :unit_measure_id
end
