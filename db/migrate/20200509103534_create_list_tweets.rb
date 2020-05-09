class CreateListTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :list_tweets do |t|
      t.integer  :list_id
      t.integer  :tweet_id

      t.timestamps
    end
  end
end
