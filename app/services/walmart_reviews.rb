require 'mechanize'
require 'date'
require 'json'

class WalmartReviews
  def initialize(review_request)
    @review_request = review_request
    @product_id = review_request.product_id
  end

  def call
    @page = agent.get url
    reviews = fetch_reviews
    filtered_reviews = filter_reviews(reviews)
    return unless filtered_reviews.any?
    store_reviews(filtered_reviews)

    call
  end

  private

  def agent
    @agent ||= Mechanize.new
  end

  def url
    "https://www.walmart.com/reviews/product/#{product_id}?limit=20&page=#{page_number}&sort=relevancy"
  end

  def page_number
    @page_number = @page_number.to_i + 1
  end

  def fetch_reviews
    page.css('p.js-customer-review-text').to_a.map(&:content).uniq
  end

  def filter_reviews(reviews)
    reviews.select {|r| r.downcase.include? review_request.search_text }
  end

  def store_reviews(reviews)
    reviews.each do |review|
      review_request.product_reviews.build(review_text: review).save
    end
  end

  attr_reader :product_id, :review_request
  attr_accessor :page
end