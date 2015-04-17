class Area < ActiveRecord::Base
  include UuidHelper
  belongs_to :zone
  has_many :blocks
  belongs_to :farm :through :zone
end
