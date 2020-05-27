module Database
  class SaveTweet
    # TODO: Refactoring (Not good for STI)
    def self.by_search_word_tweet(search_query, *tweets)
      tweets.flatten!

      # TODO: Should be a transaction (a bulk INSERT)
      tweets.each do |tweet|
        user = User.new(
          id_number: tweet.user.id,
          handle: CGI.unescapeHTML(tweet.user.name),
          screen_name: CGI.unescapeHTML(tweet.user.screen_name),
          serialized_object: tweet.user.to_json
        )

        by_search_word_tweet = BySearchWordTweet.new(
          id_number: tweet.id,
          full_text: CGI.unescapeHTML(tweet.full_text),
          serialized_object: tweet.to_json,
          search_word: search_query,
          user_id_number: user.id_number
        )
        by_search_word_tweet.user = user

        by_search_word_tweet.save
      end
    end

    def self.by_specific_user_tweet(*tweets)
      tweets.flatten!

      # TODO: 引数に user を取る？
      tweet_by_this_user = tweets[0]
      user = User.new(
        id_number: tweet_by_this_user.user.id,
        handle: CGI.unescapeHTML(tweet_by_this_user.user.name),
        screen_name: CGI.unescapeHTML(tweet_by_this_user.user.screen_name),
        serialized_object: tweet_by_this_user.user.to_json
      )
      user.save

      tweets.each do |tweet|
        by_specific_user_tweet = BySpecificUserTweet.new(
          id_number: tweet.id,
          full_text: CGI.unescapeHTML(tweet.full_text),
          serialized_object: tweet.to_json,
          user: user,
          user_id_number: user.id_number
        )

        by_specific_user_tweet.save
      end
    end

    def self.by_specific_id_tweets(*tweets)
      tweets.flatten!

      tweets.each do |tweet|
        user = User.new(
          id_number: tweet.user.id,
          handle: CGI.unescapeHTML(tweet.user.name),
          screen_name: CGI.unescapeHTML(tweet.user.screen_name),
          serialized_object: tweet.user.to_json
        )

        by_specific_id_tweet = BySpecificIdTweet.new(
          id_number: tweet.id,
          full_text: CGI.unescapeHTML(tweet.full_text),
          serialized_object: tweet.to_json,
          user_id_number: user.id_number
        )
        by_specific_id_tweet.user = user

        by_specific_id_tweet.save
      end
    end

    def self.by_list_tweet(list, *tweets)
      tweets.flatten!

      target_list = List.new(
        id_number: list.id,
        name: CGI.unescapeHTML(list.name),
        slug: CGI.unescapeHTML(list.slug),
        serialized_object: list.to_json
      )
      target_list.save

      tweets.each do |tweet|
        user = User.new(
          id_number: tweet.user.id,
          handle: CGI.unescapeHTML(tweet.user.name),
          screen_name: CGI.unescapeHTML(tweet.user.screen_name),
          serialized_object: tweet.user.to_json
        )
        user.save

        by_specific_list_tweet = ByListTweet.new(
          id_number: tweet.id,
          full_text: CGI.unescapeHTML(tweet.full_text),
          serialized_object: tweet.to_json,
          list: target_list,
          user: user,
          user_id_number: user.id_number,
          list_id_number: target_list.id_number
        )
        by_specific_list_tweet.save
      end
    end
  end
end
