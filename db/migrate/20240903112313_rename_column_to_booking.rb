class RenameColumnToBooking < ActiveRecord::Migration[7.1]
  def change
    rename_column :bookings, :Num_of_Tickets, :num_of_tickets
  end
end
