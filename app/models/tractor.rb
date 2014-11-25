class Tractor < ActiveRecord::Base
  include UuidHelper

  has_attached_file :photo, 
                    :styles => { :thumb => "80x80>", :small => "157x157>", :medium => "274x274>" },
                    :url => "/assets/tractors/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/tractors/:id/:style/:basename.:extension"
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  validates :name, length: { maximum: 50 }, presence: true
  validates :horse_power, numericality: true
  validates :fuel_capacity, numericality: true
  validates :value, numericality: true

  has_one :maintenance
end
  