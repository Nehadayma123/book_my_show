class ChangeColumnNullInMovies < ActiveRecord::Migration[7.1]
  def change
    change_column_null :movies, :language, false
  end
end
