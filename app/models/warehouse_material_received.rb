class WarehouseMaterialReceived < ActiveRecord::Base
  include UuidHelper

  belongs_to :warehouse_item_transaction

  validates :warehouse_item_transaction_id, length: { maximum: 36 }, :presence => { message: "Warehouse Material Transaction is required" }
  validates :received_date, :presence => { message: "Received date is required" }
  
  scope :select_all_receives, select('DISTINCT(warehouse_item_transaction_id)')

  scope :find_by_requested_number, -> requested_number { where("requested_number like ?", "%#{requested_number}%") }

end
