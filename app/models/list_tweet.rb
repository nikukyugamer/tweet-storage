class ListTweet < ApplicationRecord
  belongs_to :list
  belongs_to :tweet
end
