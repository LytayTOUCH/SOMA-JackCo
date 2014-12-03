class Resource < ActiveRecord::Base
  include UuidHelper
  # has_many :roles
  belongs_to :role


  validates :name, length: { maximum: 50 }, presence: true
end
