class User < ApplicationTweetStorageRecord
  extend TwitterClient

  has_many :tweets
  has_many :lists

  def self.save_serialized_data(*users)
    serialized(users).each do |data|
      de_serialized_data = Twitter::User.new(JSON.parse(data, symbolize_names: true))

      user_object = User.new(
        id_number: de_serialized_data.id,
        name: de_serialized_data.name,
        screen_name: de_serialized_data.screen_name,
        serialized_object: data
      )

      # FIXME: In case of errors, notify and write to logger
      # ex. 'Twitter::Error::NotFound: No user matches for specified terms.'
      user_object.save
    end
  end

  def self.serialized(*users)
    # There are two methods, #user and #users
    # https://www.rubydoc.info/gems/twitter/Twitter/REST/Users
    user_objects = client.users(users)
    user_objects.map(&:to_json)
  end
end
