class Implement < ActiveRecord::Base
  include UuidHelper

  has_attached_file :photo, 
                    :styles => { :thumb => "80x80>", :small => "157x157>", :medium => "274x274>" },
                    :url => "/assets/implements/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/implements/:id/:style/:basename.:extension"
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  validates :name, length: { maximum: 50 }, :presence => { message: "Implement name is required." }
  validates :implement_type_uuid, length: { maximum: 36 }, :presence => { message: "Implement Type is required." }
  validates :year, length: { maximum: 10 }

  has_one :maintenance
  
end
