class Machinery < ActiveRecord::Base
  include UuidHelper
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :machinery_type, foreign_key: :machinery_type_id
  belongs_to :warehouse, foreign_key: :warehouse_id
  
  has_many :input_tasks, foreign_key: :machinery_id

  has_many :output_tasks, through: :output_use_machineries
  has_many :output_tasks, foreign_key: :machinery_id
  
  has_paper_trail
end
