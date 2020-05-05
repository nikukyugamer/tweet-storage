class BySearchWordTweet < Tweet
  validates :search_word, presence: true
end
