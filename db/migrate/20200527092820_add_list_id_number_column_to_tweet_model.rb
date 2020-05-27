class AddListIdNumberColumnToTweetModel < ActiveRecord::Migration[6.0]
  def up
    add_column :tweets, :list_id_number, :bigint
  end

  def down
    remove_column :tweets, :list_id_number, :bigint
  end
end
