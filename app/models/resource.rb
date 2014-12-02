class Resource < ActiveRecord::Base
  include UuidHelper
  has_many :roles

  validates :name, length: { maximum: 50 }, presence: true
end
