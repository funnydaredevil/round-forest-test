json.extract! review_request, :id, :product_id, :search_text, :created_at, :updated_at
json.url review_request_url(review_request, format: :json)