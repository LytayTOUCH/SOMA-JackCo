class Resource < ActiveRecord::Base
  include UuidHelper
  # has_many :roles
  belongs_to :role
  # has_and_belongs_to_many :roles

  validates :name, length: { maximum: 50 }, presence: true
end