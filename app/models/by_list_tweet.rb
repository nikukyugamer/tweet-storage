class ByListTweet < Tweet
  has_many :list_tweets
  has_many :lists, through: :list_tweets
end
