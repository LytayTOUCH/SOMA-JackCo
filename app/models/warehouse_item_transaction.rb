class WarehouseItemTransaction < ActiveRecord::Base
  include UuidHelper

  has_many :warehouse_material_receiveds

  validates :sender_id, length: { maximum: 36 }, presence: true
  validates :receiver_id, length: { maximum: 36 }, presence: true
  validates :material_id, length: { maximum: 36 }, presence: true
  validates :requested_number, length: { maximum: 40 }, presence: true
  validates :requested_date, presence: true
  validates :amount, presence: true
  validates :due_date, presence: true

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

  has_paper_trail

end 
