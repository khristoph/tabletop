class AddRuleLinkToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :rule_link, :string
  end
end
