class ByListTweet < Tweet
  validates :list_id, presence: true
  validates :list_id_number, presence: true

  belongs_to :list
end
