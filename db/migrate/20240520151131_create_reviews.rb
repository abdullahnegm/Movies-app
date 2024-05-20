class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.bigint :movie_id, null: false
      t.bigint :user_id
      t.integer :rating, null: false
      t.string :review, null: false

      t.index :movie_id
      t.index :user_id

      t.timestamps
    end
  end
end
