class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :year
      t.string :director
      t.text :actors, array: true, default: []
      t.string :filming_location
      t.string :country

      t.index :actors

      t.timestamps
    end
  end
end
