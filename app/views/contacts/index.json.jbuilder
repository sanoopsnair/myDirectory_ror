json.array!(@contacts) do |contact|
  json.extract! contact, :id, :user_id, :contact_name, :phone_number, :description
  json.url contact_url(contact, format: :json)
end
