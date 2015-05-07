class WarehouseItemTransaction < ActiveRecord::Base
  include UuidHelper

  has_many :warehouse_material_receiveds

  validates :sender_id, length: { maximum: 36 }, :presence => { message: "Sending warehouse is required." }
  validates :receiver_id, length: { maximum: 36 }, :presence => { message: "Receving warehouse is required." }
  validates :material_id, length: { maximum: 36 }, :presence => { message: "Material is required." }
  validates :requested_number, length: { maximum: 40 }, :presence => { message: "Requested number is required." }
  validates :requested_date, :presence => { message: "Requested date is required" }
  validates :amount, :presence => { message: "Material quantity is required." }
  validates :due_date, :presence => { message: "Due date is required." }

  scope :find_by_requested_transaction_date, -> requested_date {
    if requested_date.present?
      where("requested_date >= ?", requested_date ) 
    end
  }

  scope :find_by_received_transaction_date, -> received_date {
    if received_date.present?
      where("received_date <= ?", received_date ) 
    end
  }

  scope :find_by_requested_number, -> requested_number { where("requested_number like ?", "%#{requested_number}%") }

end 
