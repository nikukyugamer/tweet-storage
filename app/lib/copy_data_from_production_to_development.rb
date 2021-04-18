class CopyDataFromProductionToDevelopment
  def self.execute
    Tweet.establish_connection :production
    User.establish_connection :production
    target_tweets = BySearchWordTweet.where(search_word: '#幻水総選挙2020')

    # TODO: transaction の意味がないので Bulk insert にする
    ActiveRecord::Base.transaction do
      target_tweets.each_with_index do |tweet, i|
        Tweet.establish_connection :production
        User.establish_connection :production

        user = tweet.user

        Tweet.establish_connection :development
        User.establish_connection :development

        duplicated_tweet = tweet.dup
        duplicated_user = user.dup
        duplicated_tweet.user = duplicated_user

        duplicated_user.save!
        duplicated_tweet.save!
      end
    end
  end
end
