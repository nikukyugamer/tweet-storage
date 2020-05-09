class List < ApplicationRecord
  has_many :list_tweets
  has_many :tweets, through: :list_tweets

  delegate :description, to: :deserialize
  delegate :full_name, to: :deserialize
  delegate :member_count, to: :deserialize
  delegate :mode, to: :deserialize
  delegate :name, to: :deserialize
  delegate :slug, to: :deserialize
  delegate :subscriber_count, to: :deserialize
  delegate :attrs, to: :deserialize
  delegate :members_uri, to: :deserialize
  delegate :subscribers_uri, to: :deserialize
  delegate :uri, to: :deserialize
  delegate :uri?, to: :deserialize
  delegate :created?, to: :deserialize

  def deserialize
    Twitter::List.new(JSON.parse(serialized_object, symbolize_names: true))
  end
end
