module TwitterApi
  class CollectTweet
    extend TwitterClient

    class << self
      # データベースにある最新の tweet id number の次の tweet id number から、現在の最新の tweet までを取得する
      # 現在の最新ツイートを取得するまで実質無限ループをするので、対象ツイート数が 101 以上でも取得できる
      def continue_from_next_tweet_id_number_with_loop_by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 1, max_id: 9_000_000_000_000_000_000 })
        from_specific_tweet_id_number_to_latest_with_loop_by_search(
          search_query,
          BySearchWordTweet.where(
            search_word: search_query
          ).max_id_number,
          options
        )
      end

      def all_by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 1, max_id: 9_000_000_000_000_000_000 })
        # TODO: Are '100' and '30' appropriate?
        max_loop_number   = ENV['MAX_LOOP_NUMBER_BY_SEARCH'] || 100
        interval_seconds  = ENV['INTERVAL_SECONDS_OF_GETTING_TWEET_BY_SEARCH'] || 30
        result_tweets     = []

        max_loop_number.to_i.times do |i|
          return_tweets = client.search(search_query, options).take(options[:count])
          break if return_tweets.blank? # NOTE: return_tweets.size < options[:count]

          sleep(interval_seconds.to_i)
          result_tweets << return_tweets

          options[:max_id] = minimum_id_number_in_tweet_array(return_tweets) - 1
        end

        result_tweets.flatten
      end

      # TODO: Refactoring (options arguments)
      def from_specific_tweet_id_number_to_latest_with_loop_by_search(search_query, specific_tweet_id_number, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 1, max_id: 9_000_000_000_000_000_000 })
        options[:since_id] = specific_tweet_id_number
        all_by_search(search_query, options)
      end

      # cf. Standard search operators
      # https://developer.twitter.com/en/docs/tweets/rules-and-filtering/overview/standard-operators
      # http://westplain.sakuraweb.com/translate/twitter/Documentation/REST-APIs/Public-API/The-Search-API.cgi
      # 検索用API は全ツイートを完璧にインデックス化している訳ではなく、最近のツイートをインデックス化しています。 現時点では、6-9日間のツイートがインデックス化されています。
      def by_search(search_query, options = { result: 'recent', count: 100, tweet_mode: 'extended', since_id: 1, max_id: 9_000_000_000_000_000_000 })
        # If 'take' isn't used, loop to execute getting tweet method until completing to get 3,200 tweets
        client.search(search_query, options).take(options[:count])
      end

      def minimum_id_number_in_tweet_array(tweet_array)
        tweet_array.map(&:id).min
      end

      # こちらのメソッドでないと例外が返ってこない
      # ただし、全てのツイートにこれを実行すると、一つずつのツイートに対して 1 API を消費することになる
      def specific_tweet_by_tweet_id_number(tweet_id_number)
        client.status(tweet_id_number)
      end

      # こちらのメソッドでは、取得できなかったツイートは戻り値の中に入ってこないだけになる（例外は発生しない）
      def specific_tweets_by_tweet_id_numbers(*tweet_id_numbers)
        client.statuses(tweet_id_numbers)
      end

      # https://www.rubydoc.info/gems/twitter/Twitter/REST/Timelines#user_timeline-instance_method
      # user_identify: A Twitter user ID, screen name, URI, or object.
      # This method can only return up to 3,200 Tweets.
      def specific_tweets_by_user(user_identify, options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
        client.user_timeline(user_identify, options)
      end

      # https://www.rubydoc.info/gems/twitter/Twitter/REST/Timelines#home_timeline-instance_method
      # Note: This method can only return up to 800 Tweets, including retweets.
      def home_timeline_of_api_user(options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
        client.home_timeline(options)
      end

      # https://developer.twitter.com/en/docs/accounts-and-users/create-manage-lists/api-reference/get-lists-statuses
      # https://www.rubydoc.info/gems/twitter/Twitter/REST/Lists
      # Requests / 15-min window (user auth): 900
      # list_owner_user: A Twitter user ID, screen name, URI, or object.
      # list_identify: A Twitter list ID, slug, URI, or object.
      # count: デフォルトで 20、max は 200
      # since_id が 0 の場合は since_id parameter is invalid. (Twitter::Error::BadRequest) が返ってくるため、since_id = 1 にする必要がある
      # max_id が 9_000_000_000_000_000_000 の場合は空の配列が返ってくるので、9_058_973_030_702_669_825 あたり以下にする必要がある
      def specific_tweets_by_list(list_identify, options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
        client.list_timeline(list_identify, options)
      end

      # TODO: Refactoring
      def all_by_specific_user(user_identify, options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
        # TODO: Are '100' and '30' appropriate?
        max_loop_number   = ENV['MAX_LOOP_NUMBER_BY_SPECIFIC_USER'] || 35
        interval_seconds  = ENV['INTERVAL_SECONDS_OF_GETTING_TWEET_BY_SPECIFIC_USER'] || 30
        result_tweets     = []

        max_loop_number.to_i.times do |i|
          return_tweets = client.user_timeline(user_identify, options)
          break if return_tweets.blank? # NOTE: return_tweets.size < options[:count]

          sleep(interval_seconds.to_i)
          result_tweets << return_tweets

          options[:max_id] = minimum_id_number_in_tweet_array(return_tweets) - 1
        end

        result_tweets.flatten
      end

      def all_by_home_timeline_of_api_user(options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
        # TODO: Are '100' and '30' appropriate?
        max_loop_number   = ENV['MAX_LOOP_NUMBER_BY_HOME_TIMELINE_OF_API_USER'] || 100
        interval_seconds  = ENV['INTERVAL_SECONDS_OF_GETTING_TWEET_BY_HOME_TIMELINE_OF_API_USER'] || 30
        result_tweets     = []

        max_loop_number.to_i.times do |i|
          return_tweets = client.home_timeline(options)
          break if return_tweets.blank? # NOTE: return_tweets.size < options[:count]

          sleep(interval_seconds.to_i)
          result_tweets << return_tweets

          options[:max_id] = minimum_id_number_in_tweet_array(return_tweets) - 1
        end

        result_tweets.flatten
      end

      # TODO: Refactoring
      def all_by_specific_list(list_identify, options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
        # TODO: Are '100' and '30' appropriate?
        max_loop_number   = ENV['MAX_LOOP_NUMBER_BY_SPECIFIC_LIST'] || 100
        interval_seconds  = ENV['INTERVAL_SECONDS_OF_GETTING_TWEET_BY_SPECIFIC_LIST'] || 30
        result_tweets     = []

        max_loop_number.to_i.times do |i|
          return_tweets = client.list_timeline(list_identify, options)
          break if return_tweets.blank? # NOTE: return_tweets.size < options[:count]

          sleep(interval_seconds.to_i)
          result_tweets << return_tweets

          options[:max_id] = minimum_id_number_in_tweet_array(return_tweets) - 1
        end

        result_tweets.flatten
      end
    end
  end
end
