module TwitterClient
  extend ActiveSupport::Concern

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY'] || Rails.application.credentials[:twitter_consumer_key]
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET'] || Rails.application.credentials[:twitter_consumer_secret]
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN'] || Rails.application.credentials[:twitter_access_token]
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET'] || Rails.application.credentials[:twitter_access_secret]
    end
  end
end
