class List < ApplicationRecord
  has_many :list_tweets
  has_many :tweets, through: :list_tweets
end
