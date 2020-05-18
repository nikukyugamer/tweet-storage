require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

module TweetStorage
  class Application < Rails::Application
    config.load_defaults 6.0

    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :utc
  end
end
