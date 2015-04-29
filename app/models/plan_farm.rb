class PlanFarm < ActiveRecord::Base
  include UuidHelper

  belongs_to :farm, foreign_key: :farm_id

  has_many :plan_phases, foreign_key: :plan_farm_id, dependent: :destroy
  
  validates_presence_of :farm_id, :message => "Farm can not empty."
  validates_presence_of :for_year, :message => "Year can not empty."

  accepts_nested_attributes_for :plan_phases

end
