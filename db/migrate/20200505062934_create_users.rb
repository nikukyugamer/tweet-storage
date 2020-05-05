class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.bigint 'id_number', null: false
      # These two columns are verbose..., but with them, we human can read records smoothly
      t.string 'name', null: false
      t.string 'screen_name', null: false
      t.json 'serialized_object', null: false

      t.timestamps
    end

    add_index :users, :id_number
    add_index :users, :name
    add_index :users, :screen_name
  end
end
