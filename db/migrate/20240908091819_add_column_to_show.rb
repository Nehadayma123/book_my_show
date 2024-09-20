class AddColumnToShow < ActiveRecord::Migration[7.1]
  def change
    add_column :shows, :show_time, :datetime, null: false
  end
end
