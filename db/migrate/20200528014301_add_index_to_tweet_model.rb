class AddIndexToTweetModel < ActiveRecord::Migration[6.0]
  def up
    add_index :tweets, :user_id_number
    add_index :tweets, :list_id_number
  end

  def down
    remove_index :tweets, :user_id_number
    remove_index :tweets, :list_id_number
  end
end
