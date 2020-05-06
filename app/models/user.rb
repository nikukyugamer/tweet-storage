class User < ApplicationRecord
  extend TwitterClient
  extend UsefulMethods

  has_many :tweets

  # TODO: Refactoring
  # Pick up the latest record
  scope :remove_duplicated, lambda {
    user_id_numbers             = pluck(:id_number)
    duplicated_user_id_numbers  = user_id_numbers.select{|id_number| user_id_numbers.count(id_number) > 1}.uniq
    removed_user_ids = []

    duplicated_user_id_numbers.each do |id_number|
      target_user_records = where(id_number: id_number)
      target_user_latest_record = where(id_number: id_number).order(created_at: :desc).first

      target_user_records.each do |record|
        # Old records will be removed
        removed_user_ids << record.id if record.created_at < target_user_latest_record.created_at
      end
    end

    where.not(id: removed_user_ids)
  }

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
