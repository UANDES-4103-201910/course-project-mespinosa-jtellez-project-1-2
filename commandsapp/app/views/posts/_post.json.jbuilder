json.extract! post, :id, :title, :creation_date, :description, :location, :open, :solved, :user, :created_at, :updated_at
json.url post_url(post, format: :json)
