class WarehouseItemTransaction < ActiveRecord::Base
  include UuidHelper

  validates :sender_id, length: { maximum: 36 }, presence: true
  validates :receiver_id, length: { maximum: 36 }, presence: true
  validates :material_id, length: { maximum: 36 }, presence: true
  validates :transaction_status, length: { maximum: 20 }, presence: true
  validates :requested_number, length: { maximum: 40 }, presence: true
  validates :created_by, length: { maximum: 36 }, presence: true
  validates :updated_by, length: { maximum: 36 }, presence: true
  validates :requested_date, presence: true
end
