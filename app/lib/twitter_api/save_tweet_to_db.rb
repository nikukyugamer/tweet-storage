module TwitterApi
  class SaveTweetToDb
    extend TwitterClient

    # TODO: Refactoring (Not good for STI)
    def self.execute_by_search_word_tweet(search_query, *tweets)
      tweets.flatten!

      # TODO: Should be a transaction (a bulk INSERT)
      tweets.each do |tweet|
        user = User.new(
          id_number: tweet.user.id,
          handle: tweet.user.name,
          screen_name: tweet.user.screen_name,
          serialized_object: tweet.user.to_json
        )

        by_search_word_tweet = BySearchWordTweet.new(
          id_number: tweet.id,
          full_text: tweet.full_text,
          serialized_object: tweet.to_json,
          search_word: search_query
        )
        by_search_word_tweet.user = user

        by_search_word_tweet.save
      end
    end
  end
end

