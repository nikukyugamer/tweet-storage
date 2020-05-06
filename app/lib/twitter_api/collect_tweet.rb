module TwitterApi
  class CollectTweet
    extend TwitterClient

    class << self
      # cf. Standard search operators
      # https://developer.twitter.com/en/docs/tweets/rules-and-filtering/overview/standard-operators
      def by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 0, max_id: 9_999_999_999_999_999_999 })
        # If 'take' isn't used, loop to execute getting tweet method until completing to get 3,200 tweets
        client.search(search_query, options).take(options[:count])
      end

      def continue_from_next_tweet_id_number_by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 0, max_id: 9_999_999_999_999_999_999 })
        options[:since_id] = BySearchWordTweet.where(search_word: search_query).max_id_number
        by_search(search_query)
      end

      def all_by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 0, max_id: 9_999_999_999_999_999_999 })
        # TODO: Are '64' and '30 appropriate?
        max_loop_number = 64
        interval_seconds = 30
        result_tweets = []

        max_loop_number.times do |i|
          return_tweets = client.search(search_query, options).take(options[:count])
          break if return_tweets.blank? # NOTE: return_tweets.size < options[:count]

          sleep(interval_seconds)
          result_tweets << return_tweets

          options[:max_id] = minimum_id_number_in_tweet_array(return_tweets) - 1
        end

        result_tweets.flatten
      end

      def minimum_id_number_in_tweet_array(tweet_array)
        tweet_array.map(&:id).min
      end
    end
  end
end
