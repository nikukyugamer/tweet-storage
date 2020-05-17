module Database
  class SaveTweet
    # TODO: Refactoring (Not good for STI)
    def self.by_search_word_tweet(search_query, *tweets)
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
          full_text: CGI.unescapeHTML(tweet.full_text),
          serialized_object: tweet.to_json,
          search_word: search_query
        )
        by_search_word_tweet.user = user

        by_search_word_tweet.save
      end
    end

    # TODO: Refactoring (Not good for STI)
    def self.by_specific_user_tweet(*tweets)
      tweets.flatten!

      # TODO: Should be a transaction (a bulk INSERT)
      tweets.each do |tweet|
        user = User.new(
          id_number: tweet.user.id,
          handle: tweet.user.name,
          screen_name: tweet.user.screen_name,
          serialized_object: tweet.user.to_json
        )

        by_specific_user_tweet = BySpecificUserTweet.new(
          id_number: tweet.id,
          full_text: CGI.unescapeHTML(tweet.full_text),
          serialized_object: tweet.to_json
        )
        by_specific_user_tweet.user = user

        by_specific_user_tweet.save
      end
    end

    # TODO: Refactoring (Not good for STI)
    def self.by_specific_id_tweets(*tweets)
      tweets.flatten!

      # TODO: Should be a transaction (a bulk INSERT)
      tweets.each do |tweet|
        user = User.new(
          id_number: tweet.user.id,
          handle: tweet.user.name,
          screen_name: tweet.user.screen_name,
          serialized_object: tweet.user.to_json
        )

        by_specific_id_tweet = BySpecificIdTweet.new(
          id_number: tweet.id,
          full_text: CGI.unescapeHTML(tweet.full_text),
          serialized_object: tweet.to_json
        )
        by_specific_id_tweet.user = user

        by_specific_id_tweet.save
      end
    end

    # TODO: Refactoring (Not good for STI)
    def self.by_list_tweet(list, *tweets)
      tweets.flatten!
      by_specific_list_tweets = []

      # TODO: Should be a transaction (a bulk INSERT)
      tweets.each do |tweet|
        user = User.new(
          id_number: tweet.user.id,
          handle: tweet.user.name,
          screen_name: tweet.user.screen_name,
          serialized_object: tweet.user.to_json
        )

        by_specific_list_tweet = ByListTweet.new(
          id_number: tweet.id,
          full_text: CGI.unescapeHTML(tweet.full_text),
          serialized_object: tweet.to_json,
          user: user
        )

        by_specific_list_tweets << by_specific_list_tweet
      end

      target_list = List.new(
        id_number: list.id,
        name: list.name,
        slug: list.slug,
        serialized_object: list.to_json,
        tweets: by_specific_list_tweets
      )

      target_list.save
    end
  end
end
