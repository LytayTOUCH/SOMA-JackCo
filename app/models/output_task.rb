class OutputTask < ActiveRecord::Base
  include UuidHelper

  belongs_to :block
  belongs_to :labor
  belongs_to :planting_project
  belongs_to :warehouse_production_amount
  belongs_to :user




end
