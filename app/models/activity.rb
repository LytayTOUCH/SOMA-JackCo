class Activity < ActiveRecord::Base
  include UuidHelper

  belongs_to :activity_type, foreign_key: :activity_type_uuid

  validates :date, presence: true
  validates :activity_type_uuid, length: { maximum: 36 }, presence: true
end
