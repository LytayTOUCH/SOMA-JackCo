class WarehouseMaterialReceived < ActiveRecord::Base
  include UuidHelper

  belongs_to :warehouse_item_transaction

  validates :warehouse_item_transaction_id, length: { maximum: 36 }, presence: true
  validates :received_date, presence: true
  
  has_paper_trail

end
