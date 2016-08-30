class ReviewRequest < ActiveRecord::Base
  has_many :product_reviews
end
