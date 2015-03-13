class WarehouseMaterialReceived < ActiveRecord::Base
  include UuidHelper

  belongs_to :warehouse_item_transaction

  validates :warehouse_item_transaction_id, length: { maximum: 36 }, presence: true
  validates :received_date, presence: true
  validates :remaining_amount, presence: true
  validates :created_by, length: { maximum: 36 }, presence: true
  validates :updated_by, length: { maximum: 36 }, presence: true

end
