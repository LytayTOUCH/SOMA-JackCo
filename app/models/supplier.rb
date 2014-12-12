class Supplier < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true
  validates :contact_person, length: { maximum: 100 }
  validates :phone, length: { maximum: 20 }
  validates :email, length: { maximum: 100 }

  has_one :material

  scope :find_by_name, -> name { where("name like ?", "%#{name}%") }
end
