class AddColumnnToShow < ActiveRecord::Migration[7.1]
  def change
    add_column :shows, :price, :integer, null: false, default: 100
  end
end
