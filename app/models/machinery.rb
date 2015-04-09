class Machinery < ActiveRecord::Base
  include UuidHelper
  
  validates :name, :machinery_type_id, :source, presence: true
  validate :planting_project_can_not_be_null_if_source_is_own_project
 
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :machinery_type, foreign_key: :machinery_type_id
  belongs_to :warehouse, foreign_key: :warehouse_id
  
  has_many :input_tasks, foreign_key: :machinery_id

  has_many :output_tasks, through: :output_use_machineries
  has_many :output_tasks, foreign_key: :machinery_id
  
  def planting_project_can_not_be_null_if_source_is_own_project
    if source.present? && source == "Own Project"
      errors.add(:planting_project_id, "can't be blank")
    end
  end
end
