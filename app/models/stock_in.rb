class StockIn < ActiveRecord::Base
  include UuidHelper

  belongs_to :warehouse, foreign_key: :warehouse_id
  belongs_to :material, foreign_key: :material_id
  belongs_to :labor, foreign_key: :labor_id

  validates :warehouse_id, length: {maximum: 36}, presence: true
  validates :material_id, length: {maximum: 36}, presence: true
  validates :labor_id, length: {maximum: 36}, presence: true
  validates :reference_number, length: {maximum: 30}, presence: true
  validates :stock_in_date, presence: true
  validates :amount, presence: true
  validate :amount_must_greater_than_zero
  
  def amount_must_greater_than_zero
    if material_id.present? && amount.present? && amount <= 0
      errors.add(:amount, "must be grater than zero")
    end
  end
end
