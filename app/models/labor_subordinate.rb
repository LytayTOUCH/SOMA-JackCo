class LaborSubordinate < ActiveRecord::Base
  belongs_to :labor, foreign_key: :labor_uuid
  belongs_to :labor, foreign_key: :subordinate_uuid
end
