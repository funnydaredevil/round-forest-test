class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.references :review_request, index: true, foreign_key: true
      t.text :review_text

      t.timestamps null: false
    end
  end
end
