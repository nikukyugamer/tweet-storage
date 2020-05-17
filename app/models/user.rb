class User < ApplicationRecord
  extend TwitterClient
  extend UsefulMethods

  has_one :tweet

  # TODO: Refactoring
  # https://rdoc.info/gems/twitter/Twitter/User
  delegate :connections, to: :deserialize
  delegate :email, to: :deserialize
  delegate :favourites_count, to: :deserialize
  delegate :followers_count, to: :deserialize
  delegate :friends_count, to: :deserialize
  delegate :lang, to: :deserialize
  delegate :listed_count, to: :deserialize
  delegate :location, to: :deserialize
  delegate :profile_background_color, to: :deserialize
  delegate :profile_link_color, to: :deserialize
  delegate :profile_sidebar_border_color, to: :deserialize
  delegate :profile_sidebar_fill_color, to: :deserialize
  delegate :profile_text_color, to: :deserialize
  delegate :statuses_count, to: :deserialize
  delegate :time_zone, to: :deserialize
  delegate :utc_offset, to: :deserialize
  delegate :attrs, to: :deserialize
  delegate :uri, to: :deserialize
  delegate :website?, to: :deserialize
  delegate :profile_banner_uri?, to: :deserialize
  delegate :profile_banner_uri_https, to: :deserialize
  delegate :profile_image_uri?, to: :deserialize
  delegate :profile_image_uri_https, to: :deserialize
  delegate :created?, to: :deserialize
  delegate :created_at, to: :deserialize
  delegate :protected?, to: :deserialize

  # TODO: Refactoring
  # Pick up the latest record
  scope :remove_duplicated, lambda {
    user_id_numbers             = pluck(:id_number)
    duplicated_user_id_numbers  = user_id_numbers.select{|id_number| user_id_numbers.count(id_number) > 1}.uniq
    removed_user_index_ids = []

    duplicated_user_id_numbers.each do |id_number|
      target_user_records = where(id_number: id_number)
      target_user_latest_record = where(id_number: id_number).order(created_at: :desc).first

      target_user_records.each do |record|
        # Old records will be removed
        removed_user_index_ids << record.id if record.created_at < target_user_latest_record.created_at
      end
    end

    where.not(id: removed_user_index_ids)
  }

  def deserialize
    Twitter::User.new(JSON.parse(serialized_object, symbolize_names: true))
  end

  def self.latest
    order(id_number: :desc).first
  end

  def url
    uri.to_s
  end

  def profile_banner_url
    # :ipad_retina is the max resolution
    # https://rdoc.info/gems/twitter/Twitter/Profile#profile_image_uri_https-instance_method
    profile_banner_uri_https(:ipad_retina).to_s
  end

  def profile_image_url
    # :original is the max resolution
    # https://rdoc.info/gems/twitter/Twitter/Profile#profile_image_uri_https-instance_method
    profile_image_uri_https(:original).to_s
  end

  def screen_name
    CGI.unescapeHTML(deserialize.screen_name)
  end

  def description
    CGI.unescapeHTML(deserialize.description)
  end

  def name
    CGI.unescapeHTML(deserialize.name)
  end

  def website
    CGI.unescapeHTML(deserialize.website)
  end
end
