class AddCategoryIdToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :category_id, :integer
  end
end
