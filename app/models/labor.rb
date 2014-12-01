class Labor < ActiveRecord::Base
  include UuidHelper
  attr_reader :project_tokens, :subordinate_tokens

  validates :name, length: { maximum: 50 }, presence: true
  validates :position_uuid, length: { maximum: 36 }, presence: true

  has_one :maintenance
  
  has_many :labor_projects, dependent: :destroy, foreign_key: :labor_uuid
  has_many :projects, through: :labor_projects

  has_many :labor_subordinates, dependent: :destroy, foreign_key: :labor_uuid
  has_many :labors, through: :labor_subordinates

  def project_tokens=(ids)
    self.project_ids = ids.split(",")
  end

  def subordinate_tokens=(ids)
    self.labor_ids = ids.split(",")
  end
end
