class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.bigint 'id_number', null: false
      t.string 'name', null: false
      t.string 'slug', null: false
      t.json 'serialized_object', null: false

      t.timestamps
    end

    add_index :lists, :id_number
    add_index :lists, :name
    add_index :lists, :slug
  end
end
