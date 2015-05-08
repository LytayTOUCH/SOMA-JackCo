class JackFruit < ActiveRecord::Base
  include UuidHelper

  belongs_to :field, foreign_key: :field_uuid
  belongs_to :production_stage, foreign_key: :stage_uuid

  validates :code, length: { maximum: 50 }, :presence => { message: "JackFruit Code can't be blank." }
  validates :grown_by, length: { maximum: 30 }, :presence => { message: "Growing Method can't be blank." }
  validates :jack_fruit_type, length: { maximum: 30 }, :presence => { message: "JackFruit Type can't be blank." }
  validates :field_uuid, length: {maximum: 36}, :presence => { message: "Field can't be blank." }
  validates :stage_uuid, length: {maximum: 36}, :presence => { message: "Production stage can't be blank." }
  
  scope :find_by_jack_fruit_code, -> code { where("code like ?", "%#{code}%") }

end
