class AddColumnToSeat < ActiveRecord::Migration[7.1]
  def change
    add_column :seats, :number, :integer, null: false
    add_column :seats, :available, :boolean, null: false
  end
end
