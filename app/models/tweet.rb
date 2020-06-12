class Tweet < ApplicationRecord
  extend TwitterClient
  include UsefulMethods

  belongs_to :user

  validates :user, presence: true
  validates :user_id_number, presence: true
  validates :id_number, presence: true
  validates :full_text, presence: true
  validates :serialized_object, presence: true

  scope :order_by_id_number_desc, -> { order(id_number: :desc) }
  scope :order_by_id_number_asc, -> { order(id_number: :asc) }

  # TODO: Refactoring
  # Pick up the latest id_number record
  scope :remove_duplicated, lambda {
    tweet_id_numbers = pluck(:id_number)
    duplicated_tweet_id_numbers = tweet_id_numbers.select{|id_number| tweet_id_numbers.count(id_number) > 1}.uniq
    removed_tweet_index_ids = []

    duplicated_tweet_id_numbers.each do |id_number|
      target_tweet_records = where(id_number: id_number)
      target_tweet_latest_record = where(id_number: id_number).order(created_at: :desc).first

      target_tweet_records.each do |record|
        # Old records will be removed
        removed_tweet_index_ids << record.id if record.created_at < target_tweet_latest_record.created_at
      end
    end

    where.not(id: removed_tweet_index_ids)
  }

  scope :remove_retweet, lambda {
    retweet_tweet_index_ids = []
    select do |record|
      retweet_tweet_index_ids << record.id if record.retweet?
    end

    where.not(id: retweet_tweet_index_ids)
  }

  # id_number 以外で List を指定すると一意性が保証されないので注意する
  scope :by_specific_list_with_id_number, lambda { |list_id_number|
    # tweet_id_number が同一でも、取得時刻が異なるツイートは別々にヒットしている
    where(list_id_number: list_id_number)
  }

  # id_number 以外で User を指定すると一意性が保証されないので注意する
  scope :by_specific_user_with_id_number, lambda { |user_id_number|
    # tweet_id_number が同一でも、取得時刻が異なるツイートは別々にヒットする
    where(user_id_number: user_id_number)
  }

  # @gensosenkyo: 1471724029
  # id_number 以外で User を指定すると一意性が保証されないので注意する
  scope :remove_specific_user_with_id_number, lambda { |user_id_number|
    # tweet_id_number が同一でも、取得時刻が異なるツイートは別々にヒットしている
    where.not(user_id_number: user_id_number)
  }

  # TODO: Refactoring
  # https://www.rubydoc.info/gems/twitter/Twitter/Tweet
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

  def self.latest
    order(id_number: :desc).first
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
  def tweeted_at_in_japanese
    japanese_date_expression(tweeted_at.in_time_zone('Asia/Tokyo'))
  end

  def array_of_media_urls
    media.map do |medium|
      # The default parameter is 'name=orig'
      medium.media_url_https.to_s
    end
  end

  def self.max_id_number
    order(id_number: :desc).first.id_number
  end

  def self.minimum_id_number
    order(id_number: :asc).first.id_number
  end

  def full_text
    CGI.unescapeHTML(deserialize.full_text)
  end
end
