class RemoveDefaultFromMoviesLanguage < ActiveRecord::Migration[7.1]
  def change
    change_column_default :movies, :language, nil
  end
end
