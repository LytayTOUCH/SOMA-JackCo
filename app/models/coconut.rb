class Coconut < ActiveRecord::Base
  include UuidHelper

  belongs_to :field, foreign_key: :field_uuid
  belongs_to :production_stage, foreign_key: :stage_uuid

  validates :code, length: { maximum: 50 }, :presence => { message: "Coconut Code can't be blank." }
  validates :field_uuid, length: { maximum: 36 }, :presence => { message: "Field can't be blank." }
  validates :stage_uuid, length: { maximum: 36 }, :presence => { message: "Production stage can't be blank." }
  validates :coco_type, length: { maximum: 30 }, :presence => { message: "Coconut Type can't be blank." }

  scope :find_by_coconut_code, -> code { where("code like ?", "%#{code}%") }

end
