class CreateJoinTableMoviesReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_reviews do |t|
      t.bigint :movie_id, null: false
      t.bigint :review_id, null: false

      t.index :movie_id
      t.index :review_id
      
      t.timestamps
    end
  end
end
