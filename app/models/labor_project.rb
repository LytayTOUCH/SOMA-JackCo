class LaborProject < ActiveRecord::Base
  belongs_to :labor, foreign_key: :labor_uuid
  belongs_to :project, foreign_key: :project_uuid
end
