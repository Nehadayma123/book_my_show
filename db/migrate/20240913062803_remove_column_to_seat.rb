class RemoveColumnToSeat < ActiveRecord::Migration[7.1]
  def change
    remove_column :seats, :number
    remove_column :seats, :booked
    remove_column :seats, :price
    remove_column :seats, :status
  end
end


