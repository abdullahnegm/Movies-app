class CreateJoinTableMoviesReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_reviews do |t|
      t.bigint :movie_id, null: false
      t.bigint :review_id, null: false
      t.bigint :user_id

      t.index :movie_id
      t.index :user_id
      t.index :actor_id
      
      t.timestamps
    end
  end
end
