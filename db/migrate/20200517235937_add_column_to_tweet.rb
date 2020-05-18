class AddColumnToTweet < ActiveRecord::Migration[6.0]
  def up
    add_column :tweets, :list_id, :integer
  end

  def down
    remove_column :tweets, :list_id, :integer
  end
end
