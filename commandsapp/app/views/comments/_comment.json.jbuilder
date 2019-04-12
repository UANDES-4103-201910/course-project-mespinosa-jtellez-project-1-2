json.extract! comment, :id, :user, :post, :content, :created_at, :updated_at
json.url comment_url(comment, format: :json)
