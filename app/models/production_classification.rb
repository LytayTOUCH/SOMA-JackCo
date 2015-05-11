class ProductionClassification < ActiveRecord::Base
  include UuidHelper

  has_many :production_classification_amounts, foreign_key: :production_classification_id
  
end
