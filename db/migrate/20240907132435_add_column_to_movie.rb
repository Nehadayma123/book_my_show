class AddColumnToMovie < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :language, :string, null: false, default: 'Unknown'
  end
end
