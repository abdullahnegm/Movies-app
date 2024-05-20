class CreateJoinTableMoviesActors < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_actors do |t|
      t.bigint :movie_id, null: false

      t.index :movie_id

      t.timestamps
    end
  end
end
