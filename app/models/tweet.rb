class Tweet < ApplicationTweetStorageRecord
  extend TwitterClient

  belongs_to :user

  def self.latest_specific_user_tweet(id_number: nil, screen_name: nil, name: nil)
    # TODO: Do refactoring
    target_user = User.where(name: name).order(updated_at: :desc).first unless name.nil?
    target_user = User.where(screen_name: screen_name).order(updated_at: :desc).first unless screen_name.nil?
    target_user = User.where(id_number: id_number).order(updated_at: :desc).first unless id_number.nil?

    target_user.tweets.order(id_number: :desc).order(updated_at: :desc).first
  end

  def self.save_serialized_data(*tweets)
    serialized(tweets).each do |data|
      de_serialized_data = Twitter::Tweet.new(JSON.parse(data, symbolize_names: true))
      User.save_serialized_data(de_serialized_data.user.id) unless user_record_exists?(de_serialized_data.user.id)

      target_user = de_serialized_data.user
      target_user_record = User.where(id_number: target_user.id).order(updated_at: :desc).first

      tweet_object = Tweet.new(
        user_id: target_user_record.id,
        id_number: de_serialized_data.id,
        full_text: de_serialized_data.full_text,
        serialized_object: data
      )

      # FIXME: In case of errors, notify and write to logger
      # In case of 'client.statuses' method, when a target tweet is not found, return '[]'
      tweet_object.save
    end
  end

  # Documents: https://www.rubydoc.info/gems/twitter/Twitter/REST/Timelines#user_timeline-instance_method
  # :since_id, :max_id, :count, others(hidden...)
  def self.specific_user_tweets(user, options = {})
    default_options = {
      tweet_mode: 'extended',
      count: 200
    }
    options = default_options.merge(options)
    target_user = client.users(user)

    client.user_timeline(
      target_user,
      options
    )
  end

  def self.serialized(*tweets)
    tweet_objects = client.statuses(
      tweets,
      tweet_mode: 'extended'
    )

    tweet_objects.map(&:to_json)
  end

  def self.user_record_exists?(id_number)
    User.find_by(id_number: id_number)
  end

  def self.save_data_from_search_method_result(query, options = {})
    search_result = search_result(query, options)

    save_serialized_data(tweets_from_search_result(search_result))
    save_serialized_search_result_attrs_data(search_result)
  end

  # Documents: https://www.rubydoc.info/gems/twitter/Twitter/REST/Search
  # :geocode, :lang, :locale, :result_type, :count, :until, :since_id, :max_id, :include_entities, :tweet_mode, :from, :to, :exclude('retweets'), :filter('links')
  def self.search_result(query, options = {})
    default_options = {
      tweet_mode: 'extended',
      count: 100,
      result_type: 'recent'
    }
    options = default_options.merge(options)

    # Return value: 'Twitter::SearchResults' (https://www.rubydoc.info/gems/twitter/Twitter/SearchResults)
    client.search(
      query,
      options
    )
  end

  def self.tweets_from_search_result(search_result)
    search_result.take(search_result.attrs[:search_metadata][:count])
  end

  def self.serialized_from_search_result(search_result)
    search_result.attrs.to_json
  end

  def self.save_serialized_search_result_attrs_data(search_result)
    search_result_object = SearchResultAttr.new(
      serialized_object: serialized_from_search_result(search_result)
    )
    search_result_object.save
  end
end
