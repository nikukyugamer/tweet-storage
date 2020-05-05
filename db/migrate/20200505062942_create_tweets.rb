class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.integer 'user_id', null: false
      t.bigint 'id_number', null: false
      # This column is verbose..., but with this, we human can read records smoothly
      t.string 'full_text', null: false
      t.json 'serialized_object', null: false

      t.string 'type'

      t.timestamps
    end

    add_index :tweets, :id_number
    add_index :tweets, :type
  end
end
