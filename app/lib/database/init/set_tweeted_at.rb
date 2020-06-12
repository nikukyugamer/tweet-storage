module Database
  module Init
    class SetTweetedAt
      def self.execute
        Tweet.all.each do |tweet|
          tweet.update(tweeted_at: tweet.deserialize.created_at)
        end
      end
    end
  end
end
