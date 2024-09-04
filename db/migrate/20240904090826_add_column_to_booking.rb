class AddColumnToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :movie_name, :string
    add_column :bookings, :theatre, :string
    add_column :bookings, :showtime, :time
  end
end
