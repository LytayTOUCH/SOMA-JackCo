class PlanBlock < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_area
  belongs_to :block

  validates_numericality_of :tree_amount, :only_integer => true, :allow_nil => true, 
    :greater_than => 0
end
