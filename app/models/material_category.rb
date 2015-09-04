class MaterialCategory < ActiveRecord::Base
  include UuidHelper

  has_many :materials, foreign_key: :material_cate_uuid
  has_many :warehouse_material_amounts, through: :materials
  has_many :stock_balances, foreign_key: :material_category_id
  has_many :material_sub_categories, foreign_key: :category_id

  validates :name, length: { maximum: 50 }, :presence => { message: "Material Category name is required." }
  scope :find_by_material_type_name, -> name { where("name like ?", "%#{name}%") }
end
