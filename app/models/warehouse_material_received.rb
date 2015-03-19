class WarehouseMaterialReceived < ActiveRecord::Base
  include UuidHelper

  belongs_to :warehouse_item_transaction

  validates :warehouse_item_transaction_id, length: { maximum: 36 }, presence: true
  validates :received_date, presence: true
  
  scope :select_all_receives, select('DISTINCT(warehouse_item_transaction_id)')

  scope :find_by_requested_number, -> requested_number { where("warehouse_item_transaction.requested_number like ?", "%#{requested_number}%") }

  has_paper_trail

end
