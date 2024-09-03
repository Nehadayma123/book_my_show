class CreateTheatres < ActiveRecord::Migration[7.1]
  def change
    create_table :theatres do |t|
      t.string :name, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
