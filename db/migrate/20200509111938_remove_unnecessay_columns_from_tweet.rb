class RemoveUnnecessayColumnsFromTweet < ActiveRecord::Migration[6.0]
  def up
    remove_column :tweets, :list_id_number, :integer
    remove_column :tweets, :list_name, :string
    remove_column :tweets, :list_serialized_object, :json
  end

  def down
    add_column :tweets, :list_id_number, :integer
    add_column :tweets, :list_name, :string
    add_column :tweets, :list_serialized_object, :json
  end
end
