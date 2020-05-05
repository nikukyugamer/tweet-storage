class ByListTweet < Tweet
  validates :list_id_number, presence: true
  validates :list_name, presence: true
  validates :list_serialized_object, presence: true
end
