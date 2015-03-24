class Machinery < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :machinery_type, foreign_key: :machinery_type_id
  has_many :warehouse_machinery_amounts
  
  has_paper_trail
end
