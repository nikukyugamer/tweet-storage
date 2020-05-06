class Tweet < ApplicationRecord
  extend TwitterClient
  include UsefulMethods

  belongs_to :user

  scope :order_by_id_desc, -> { order(id_number: :desc) }
  scope :latest, -> { order(id_number: :desc).first }
  scope :remove_duplicated, -> { }

  # https://www.rubydoc.info/gems/twitter/Twitter/Tweet
  # TODO: Refactoring
  delegate :retweet?, to: :deserialize
  delegate :uri, to: :deserialize
  delegate :source, to: :deserialize
  delegate :lang, to: :deserialize
  delegate :quote_count, to: :deserialize
  delegate :reply_count, to: :deserialize
  delegate :retweet_count, to: :deserialize
  delegate :favorite_count, to: :deserialize
  delegate :hashtags, to: :deserialize
  delegate :hashtags?, to: :deserialize
  delegate :media, to: :deserialize
  delegate :media?, to: :deserialize
  delegate :symbols, to: :deserialize
  delegate :symbols?, to: :deserialize
  delegate :uris, to: :deserialize
  delegate :uris?, to: :deserialize
  delegate :user_mentions, to: :deserialize
  delegate :user_mentions?, to: :deserialize
  delegate :created?, to: :deserialize
  delegate :created_at?, to: :deserialize

  delegate :strip_tags, to: 'ApplicationController.helpers'

  def deserialize
    Twitter::Tweet.new(JSON.parse(serialized_object, symbolize_names: true))
  end

  def url
    uri.to_s
  end

  def source_without_tag
    ApplicationController.helpers.strip_tags(source)
  end

  def number_of_quote
    quote_count.to_i
  end

  def number_of_reply
    reply_count.to_i
  end

  def number_of_retweet
    retweet_count.to_i
  end

  def number_of_favorite
    favorite_count.to_i
  end

  def number_of_hashtags
    hashtags.size.to_i
  end

  def array_of_hashtags
    hashtags.map(&:text)
  end

  def number_of_media
    media.size.to_i
  end

  # "2020/05/05（火） 20:54:45"
  def tweeted_at
    japanese_date_expression(created_at)
  end

  def array_of_media_urls
    media.map do |medium|
      # The default parameter is 'name=orig'
      medium.media_url_https.to_s
    end
  end

  # TODO: Change to be valid when the columns are removed
  # delegate :full_text, to: :deserialize
  # def id_number
  #   deserialize.id
  # end
end
