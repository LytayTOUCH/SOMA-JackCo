class MaterialCategory < ActiveRecord::Base
  include UuidHelper

  has_many :materials, foreign_key: :material_cate_uuid
  has_many :warehouse_material_amounts, through: :materials

  validates :name, length: { maximum: 50 }, presence: true
  scope :find_by_material_type_name, -> name { where("name like ?", "%#{name}%") }
end
