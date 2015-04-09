class Equipment < ActiveRecord::Base
  include UuidHelper

  belongs_to :equipment_type, foreign_key: :equipment_type_id
end
