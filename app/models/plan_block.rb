class PlanBlock < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_area
  belongs_to :block
end
