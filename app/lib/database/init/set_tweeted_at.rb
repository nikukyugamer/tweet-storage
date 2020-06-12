module Database
  module Init
    class SetTweetedAt
      def self.execute
        divided_number_of_tweets = Tweet.all.pluck(:id).each_slice(100).to_a

        divided_number_of_tweets.each do |number_of_tweets|
          number_of_tweets.each do |number|
            tweet = Tweet.find(number)
            # rubocop:disable Rails/SkipsModelValidations
            tweet.update_attribute(:tweeted_at, t.deserialize.created_at)
            # rubocop:enable Rails/SkipsModelValidations
          end

          sleep 3
        end
      end
    end
  end
end
