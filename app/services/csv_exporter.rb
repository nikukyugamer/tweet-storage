require 'csv'

class CsvExporter
  attr_reader :tweets, :without_rt_tweets

  def initialize(search_word)
    target_tweet_ids = BySearchWordTweet.where(search_word: search_word).remove_duplicated.pluck(:id_number).uniq

    @tweets = Tweet.where(id_number: target_tweet_ids).remove_duplicated.order(tweeted_at: :asc)
    @without_rt_tweets = @tweets.remove_retweet.order(tweeted_at: :asc)
  end

  def generate_csv(tweets)
    CSV.generate(force_quotes: true) do |temp_csv_string|
      # NOTE: batch_size を使うと単位量ごとに並び替えが行われるので order が崩れるため、使わない
      tweets.each do |tweet|
        temp_csv_string << row_values(tweet)
      end
    end
  end

  def save_file(csv, filepath='tmp/tweets.csv')
    bom = "\xEF\xBB\xBF"

    Rails.root.join(filepath).open('w') do |f|
      f.print bom
      f.puts headers.join(',')
      f.puts csv
    end
  end

  def self.execute(search_word)
    ActiveRecord::Base.logger = nil

    csv_exporter = CsvExporter.new(search_word)
    csv_with_rt = csv_exporter.generate_csv(csv_exporter.tweets)
    csv_without_rt = csv_exporter.generate_csv(csv_exporter.without_rt_tweets)

    # ファイル名を指定できるとよいが、ユニークになるからいったんこれで
    csv_exporter.save_file(
      csv_with_rt,
      "tmp/#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}_tweets_with_rt.csv"
    )
    csv_exporter.save_file(
      csv_without_rt,
      "tmp/#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}_tweets_without_rt.csv"
    )
  end

  # 完全に一点突破用メソッドなので、ここに書きたくはない
  def self.meyasubako_okawari_3
    ActiveRecord::Base.logger = nil

    hankaku = CsvExporter.new('#ラジオ目安箱おかわり3杯目')
    zenkaku = CsvExporter.new('#ラジオ目安箱おかわり３杯目')

    # 最大限の取りこぼしを防ぐために和集合を取る
    with_rt_hankaku_ids = hankaku.tweets.ids
    with_rt_zenkaku_ids = zenkaku.tweets.ids
    with_rt_ids = with_rt_hankaku_ids & with_rt_zenkaku_ids

    without_rt_hankaku_ids = hankaku.without_rt_tweets.ids
    without_rt_zenkaku_ids = zenkaku.without_rt_tweets.ids
    without_rt_ids = without_rt_hankaku_ids & without_rt_zenkaku_ids

    with_rt_tweets = Tweet.where(id: with_rt_ids).order(tweeted_at: :asc)
    without_rt_tweets = Tweet.where(id: without_rt_ids).order(tweeted_at: :asc)

    with_rt_csv = hankaku.generate_csv(with_rt_tweets)
    without_rt_csv = hankaku.generate_csv(without_rt_tweets)

    hankaku.save_file(
      with_rt_csv,
      "tmp/#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}_tweets_with_rt.csv"
    )
    hankaku.save_file(
      without_rt_csv,
      "tmp/#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}_tweets_without_rt.csv"
    )
  end

  private

  def row_values(tweet)
    convert_tweet_object_to_hash = convert_tweet_object_to_hash(tweet)

    headers.map do |header|
      convert_tweet_object_to_hash[header]
    end
  end

  def convert_tweet_object_to_hash(tweet)
    {
      'user_id_number' => tweet.user_id_number,
      'screen_name' => tweet.user.screen_name,
      'user_name' => tweet.user.name,
      'is_user_protected' => tweet.user.protected?,
      'user_profile_image_uri' => tweet.user.profile_image_uri_https&.to_s,
      'tweet_id_number' => tweet.id_number,
      'full_text' => tweet.full_text,
      'is_retweet' => tweet.retweet?,
      'source' => tweet.source,
      'lang' => tweet.lang,
      'tweeted_at' => tweet.tweeted_at,
      'tweet_url' => tweet.url
    }
  end

  def headers
    %w[
      tweet_id_number
      user_id_number
      screen_name
      user_name
      full_text
      tweeted_at
      tweet_url
      is_retweet
    ]
  end
end
