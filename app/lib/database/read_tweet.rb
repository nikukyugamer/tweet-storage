module Database
  class ReadTweet
    # TODO: Refactoring (Not good for STI)
    def self.by_general_search(search_query)
      BySearchWordTweet.where(search_word: search_query).remove_duplicated.remove_retweet.order_by_id_number_asc
    end

    def self.by_next_tweet_id_number_search(search_query, since_tweet_id_number)
      BySearchWordTweet.where('id_number > ?', since_tweet_id_number).where(search_word: search_query).remove_duplicated.remove_retweet.order_by_id_number_asc
    end

    def self.by_with_retweet_general_search(search_query)
      BySearchWordTweet.where(search_word: search_query).remove_duplicated.order_by_id_number_asc
    end

    def self.by_with_retweet_next_tweet_id_number_search(search_query, since_tweet_id_number)
      BySearchWordTweet.where('id_number > ?', since_tweet_id_number).where(search_word: search_query).remove_duplicated.order_by_id_number_asc
    end
  end
end
