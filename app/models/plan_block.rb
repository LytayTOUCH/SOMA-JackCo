class PlanBlock < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_production_status, foreign_key: :plan_production_status_uuid
  belongs_to :block, foreign_key: :block_id
  
end
