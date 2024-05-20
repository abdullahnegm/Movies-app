class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.bigint :movie_id, null: false
      t.bigint :user_id
      t.bigint :actor_id, null: false
      t.string :review, null: false

      t.index :movie_id
      t.index :user_id
      t.index :actor_id

      t.timestamps
    end
  end
end
