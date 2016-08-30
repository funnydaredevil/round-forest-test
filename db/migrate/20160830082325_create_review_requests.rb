class CreateReviewRequests < ActiveRecord::Migration
  def change
    create_table :review_requests do |t|
      t.integer :product_id
      t.string :search_text

      t.timestamps null: false
    end
  end
end
