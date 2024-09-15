class AddPriceToSeats < ActiveRecord::Migration[7.1]
  def change
    add_column :seats, :price, :decimal, null: false
  end
end
