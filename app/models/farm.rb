class Farm < ActiveRecord::Base
  include UuidHelper
  validates :name, presence: true
end
