class Machinery < ActiveRecord::Base
  include UuidHelper
  
  validates :name, :presence => { message: "Machinery Name is required." }
  validates :machinery_type_id, :presence => { message: "Machinery Type is required." }
 
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :machinery_type, foreign_key: :machinery_type_id
  belongs_to :planting_project, foreign_key: :planting_project_id
  
  has_many :input_use_machineries, foreign_key: :input_id
  has_many :input_tasks, through: :input_use_machineries

  has_many :output_tasks, through: :output_use_machineries
  has_many :output_tasks, foreign_key: :machinery_id
  
  def planting_project_can_not_be_null_if_source_is_own_project
    if source.present? && source == "Own Project" && planting_project_id==""
      errors.add(:planting_project_id, "Planting Project is required.")
    end
  end
end
