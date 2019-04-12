json.extract! profile, :id, :picture, :biography, :city, :country, :user, :created_at, :updated_at
json.url profile_url(profile, format: :json)
