class StockIn < ActiveRecord::Base
  include UuidHelper

  belongs_to :warehouse, foreign_key: :warehouse_id
  belongs_to :material, foreign_key: :material_id
  belongs_to :labor, foreign_key: :labor_id

  validates :warehouse_id, length: {maximum: 36}, :presence => { message: "Warehouse is required." }
  validates :material_id, length: {maximum: 36}, :presence => { message: "Material is required." }
  validates :labor_id, length: {maximum: 36}, :presence => { message: "User is required." }
  validates :stock_in_date, :presence => { message: "Stock in date is required." }
  validates :reference_number, length: {maximum: 30}, :presence => { message: "Reference Number is required." }
  validates :amount, :presence => { message: "Stock in Quantity is required." }
  validate :amount_must_greater_than_zero
  
  def amount_must_greater_than_zero
    if material_id.present? && amount.present? && amount <= 0
      errors.add(:amount, "must be grater than zero")
    end
  end
end
