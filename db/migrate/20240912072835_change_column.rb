class ChangeColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :seats, :seat_number, :number
    change_column :seats, :number, 'integer USING CAST(number AS integer)', null: false

    add_column :seats, :status, :string, null: false

  end
end
