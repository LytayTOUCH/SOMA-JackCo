class Activity < ActiveRecord::Base
  include UuidHelper

  belongs_to :activity_type, foreign_key: :activity_type_uuid

  validates :starts_at, presence: true
  validates :activity_type_uuid, length: { maximum: 36 }, presence: true

  def as_json(options = {})
    {
      uuid: self.uuid,
      note: self.note || "",
      start: starts_at,
      # activity_type_uuid: self.activity_type_uuid,
      title: 'hello',
      recurring: false,
      url: Rails.application.routes.url_helpers.activity_path(uuid),
      #:color => "red"
    }
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

end
