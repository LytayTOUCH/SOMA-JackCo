class Labor < ActiveRecord::Base
  include UuidHelper
  attr_reader :project_tokens

  validates :name, length: { maximum: 50 }, presence: true
  validates :position_uuid, length: { maximum: 36 }, presence: true

  has_one :maintenance
  
  has_many :labor_projects, dependent: :destroy, foreign_key: :labor_uuid
  has_many :projects, through: :labor_projects

  has_one :labor
  belongs_to :labor, foreign_key: :subordinate_uuid

  def project_tokens=(ids)
    self.project_ids = ids.split(",")
  end
end
