json.array!(@activities) do |activity|
  json.extract! activity, :uuid, :date, :note, :activity_type_uuid
  json.url activity_url(activity, format: :json)
end