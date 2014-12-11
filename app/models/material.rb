class Material < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true
  validates :quantity, numericality: true
  validates :unit, length: { maximum: 100 }, presence: true

  belongs_to :supplier, foreign_key: :supplier_uuid

  scope :find_by_name, -> name { where("name like ?", "%#{name}%") }
end
