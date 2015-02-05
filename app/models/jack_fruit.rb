class JackFruit < ActiveRecord::Base
  include UuidHelper

  belongs_to :stage, foreign_key: :stage_uuid
  belongs_to :field, foreign_key: :field_uuid

  validates :code, length: { maximum: 50 }, presence: true
  validates :grown_by, length: { maximum: 30 }, presence: true
  validates :jack_fruit_type, length: { maximum: 30 }, presence: true
  validates :field_uuid, length: {maximum: 36}, presence: true
  validates :stage_uuid, length: {maximum: 36}, presence: true

  scope :find_by_code, -> code { where("code like ?", "%#{code}%") }
end
