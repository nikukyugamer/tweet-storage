class AddUserIdNumberColumnToTweetModel < ActiveRecord::Migration[6.0]
  def up
    add_column :tweets, :user_id_number, :bigint
  end

  def down
    remove_column :tweets, :user_id_number, :bigint
  end
end
