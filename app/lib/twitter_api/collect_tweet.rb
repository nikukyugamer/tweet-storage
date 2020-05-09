module TwitterApi
  class CollectTweet
    extend TwitterClient

    class << self
      # データベースにある最新の tweet id number の次の tweet id number から、現在の最新の tweet までを取得する
      # 現在の最新ツイートを取得するまで実質無限ループをするので、対象ツイート数が 101 以上でも取得できる
      def continue_from_next_tweet_id_number_with_loop_by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 0, max_id: 9_999_999_999_999_999_999 })
        from_specific_tweet_id_number_to_latest_with_loop_by_search(
          search_query,
          BySearchWordTweet.where(
            search_word: search_query
          ).max_id_number,
          options
        )
      end

      def all_by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 0, max_id: 9_999_999_999_999_999_999 })
        # TODO: Are '100' and '30' appropriate?
        max_loop_number   = 100
        interval_seconds  = ENV['INTERVAL_SECONDS_OF_GETTING_TWEET'].to_i || 30
        result_tweets     = []

        max_loop_number.times do |i|
          return_tweets = client.search(search_query, options).take(options[:count])
          break if return_tweets.blank? # NOTE: return_tweets.size < options[:count]

          sleep(interval_seconds)
          result_tweets << return_tweets

          options[:max_id] = minimum_id_number_in_tweet_array(return_tweets) - 1
        end

        result_tweets.flatten
      end

      # TODO: Refactoring
      def from_specific_tweet_id_number_to_latest_with_loop_by_search(search_query, specific_tweet_id_number, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 0, max_id: 9_999_999_999_999_999_999 })
        options[:since_id] = specific_tweet_id_number
        all_by_search(search_query, options)
      end

      # cf. Standard search operators
      # https://developer.twitter.com/en/docs/tweets/rules-and-filtering/overview/standard-operators
      def by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 0, max_id: 9_999_999_999_999_999_999 })
        # If 'take' isn't used, loop to execute getting tweet method until completing to get 3,200 tweets
        client.search(search_query, options).take(options[:count])
      end

      def minimum_id_number_in_tweet_array(tweet_array)
        tweet_array.map(&:id).min
      end
    end
  end
end
