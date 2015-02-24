class MaterialCategory < ActiveRecord::Base
  include UuidHelper

  has_one :material

  validates :name, length: { maximum: 50 }, presence: true
  scope :find_by_material_type_name, -> name { where("name like ?", "%#{name}%") }
end
