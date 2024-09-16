class RemoveShowIndexFromSeat < ActiveRecord::Migration[7.1]
  def change
    remove_index :seats, name: :index_seats_on_show_id
  end
end
