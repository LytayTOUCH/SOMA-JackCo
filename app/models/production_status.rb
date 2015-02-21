class ProductionStatus < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true

  scope :find_by_production_status_name, -> name { where("name like ?", "%#{name}%") }
end
