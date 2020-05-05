class AddColumnsToTweetForSti < ActiveRecord::Migration[6.0]
  def change
    # ByListTweet
    add_column :tweets, :list_id_number, :bigint
    add_column :tweets, :list_name, :bigint
    add_column :tweets, :list_serialized_object, :json
    add_index  :tweets, :list_id_number

    # BySearchWordTweet
    add_column :tweets, :search_word, :string
    add_index  :tweets, :search_word

    # BySpecificIdTweet
    # Check Tweet.id_number

    # BySpecificUserTimelineTweet
    # Check Tweet.user

    # BySpecificUserTweet
    # Check Tweet.user
  end
end
