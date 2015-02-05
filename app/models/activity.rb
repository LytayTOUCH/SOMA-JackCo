class Activity < ActiveRecord::Base
  include UuidHelper

  # attr_accessible :uuid, :note, :starts_end, :activity_type_uuid

  belongs_to :activity_type, foreign_key: :activity_type_uuid

  validates :starts_at, presence: true
  validates :activity_type_uuid, length: { maximum: 36 }, presence: true

  def as_json(options = {})
    {
      id: self.uuid,
      title: self.activity_type.name,
      note: self.note || "",
      start: starts_at,
      recurring: false,
      url: Rails.application.routes.url_helpers.activity_path(uuid),
      borderColor: "green",
      backgroundColor: "green",
      textColor: "white"
    }
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  private
  def activity_params
    params.require(:activity).permit(:starts_at, :note, :activity_type_uuid)
  end

  scope :find_by_date, -> start_date {
    if start_date.present?
      where("starts_at >= ?", start_date ) 
    end
  }

end
