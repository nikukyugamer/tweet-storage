class ChangeColumnTypeInTweet < ActiveRecord::Migration[6.0]
  def up
    change_column :tweets, :list_name, :string
  end

  def down
    change_column :tweets, :list_name, 'integer USING CAST(list_name AS integer)'
  end
end
