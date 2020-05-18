class ByListTweet < Tweet
  validates :list_id, presence: true

  belongs_to :list
end
