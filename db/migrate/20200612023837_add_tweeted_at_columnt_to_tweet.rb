class AddTweetedAtColumntToTweet < ActiveRecord::Migration[6.0]
  def up
    add_column :tweets, :tweeted_at, :datetime, default: '2000-01-01 12:00:00', null: false
  end

  def down
    remove_column :tweets, :tweeted_at, :datetime
  end
end
