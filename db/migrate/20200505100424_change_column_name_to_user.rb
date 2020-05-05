class ChangeColumnNameToUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :name, :handle
  end
end
