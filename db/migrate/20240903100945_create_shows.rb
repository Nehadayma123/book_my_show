class CreateShows < ActiveRecord::Migration[7.1]
  def change
    create_table :shows do |t|
      t.time :show_time, null: false
      t.integer :available_seates, null: false
      t.references :movie, null: false, foreign_key: true
      t.references :theatre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
