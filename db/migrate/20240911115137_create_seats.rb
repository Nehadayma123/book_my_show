class CreateSeats < ActiveRecord::Migration[7.1]
  def change
    create_table :seats do |t|
      t.references :show, null: false, foreign_key: true
      t.string :seat_number
      t.boolean :booked

      t.timestamps
    end
  end
end
