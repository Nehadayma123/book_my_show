class RemoveColumnToBooking < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :movie_name, :string
  end
end
