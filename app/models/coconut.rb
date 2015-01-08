class Coconut < ActiveRecord::Base
  include UuidHelper

  belongs_to :stage, foreign_key: :stage_uuid

  validates :code, length: { maximum: 50 }, presence: true
  validates :status, length: { maximum: 30 }, presence: true
  validates :coco_type, length: { maximum: 30 }, presence: true
  validates :field_uuid, length: {maximum: 36}, presence: true
  validates :stage_uuid, length: {maximum: 36}, presence: true

end
