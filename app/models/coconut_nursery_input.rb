require 'date'

class CoconutNurseryInput < ActiveRecord::Base
  attr_accessor :qty_in_stock
  
  include UuidHelper
  
  validates :reference_number, :presence => { message: "Reference is required." }
  validates :nursery_date, :presence => { message: "Nursery Date is required." }
  validates :warehouse_id, :presence => { message: "Nursery Warehouse is required." }
  validates :input_processing_qty, :presence => { message: "Processing Qty is required." }
  validate :input_processing_qty_must_be_greater_than_zero
  validate :input_total_qty_can_not_be_greater_than_qty_in_stock
  validates :input_spoil_qty, :presence => { message: "Spoil Qty is required." }
  
  def input_processing_qty_must_be_greater_than_zero
    if input_processing_qty.present? && input_processing_qty <= 0
      errors.add(:input_processing_qty, "Processing Qty must be greater than zero.")
    end
  end
  
  def input_total_qty_can_not_be_greater_than_qty_in_stock
    if qty_in_stock.present? && input_total_qty.present? && qty_in_stock < input_total_qty
      errors.add(:input_total_qty, "Total Qty can not be greater than Qty In Stock.")
    end
  end
  
  def receivable
    retVal = ""
    
    if received
      retVal = 'RECEIVED'
    elsif receive_date > Date.today
      retVal = 'NOT YET'
    elsif receive_date < Date.today
      retVal = 'EXPIRED'
    elsif receive_date == Date.today
      retVal = 'TODAY'
    end
    
    retVal
  end
end
