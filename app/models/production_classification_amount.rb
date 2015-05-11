class ProductionClassificationAmount < ActiveRecord::Base
  include UuidHelper

  belongs_to :production_classification
  belongs_to :production_plan
end
