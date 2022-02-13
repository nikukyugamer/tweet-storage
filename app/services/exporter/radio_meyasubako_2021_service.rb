require 'csv'

module Exporter
  class RadioMeyasubako2021Service
    def self.base_tweets
      tweet_id_numbers_without_duplicated_tweets = Rails.cache.fetch('radio_meyasubako_2021/tweet_id_numbers_without_duplicated_tweets', expired_in: 24.hours) do
        BySearchWordTweet.where(search_word: '#ラジオ目安箱2021').pluck(:id_number).uniq
      end

      Tweet.where(id_number: tweet_id_numbers_without_duplicated_tweets).order(tweeted_at: :asc)
    end

    def self.without_retweets
      return [] if base_tweets.empty?

      ids_without_duplicated_tweets_and_retweets = Rails.cache.fetch('radio_meyasubako_2021/ids_without_duplicated_tweets_and_retweets', expired_in: 24.hours) do
        base_tweets.remove_retweet.pluck(:id)
      end

      Tweet.where(id: ids_without_duplicated_tweets_and_retweets).order(tweeted_at: :asc)
    end

    def self.convert_tweet_object_to_hash(tweet)
      # FIXME: ヘッダだけをうまく渡す方法を考える
      if tweet.nil?
        return {
          user_id_number: nil,
          screen_name: nil,
          user_name: nil,
          is_user_protected: nil,
          user_profile_image_uri: nil,
          tweet_id_number: nil,
          full_text: nil,
          is_retweet: nil,
          source: nil,
          lang: nil,
          tweeted_at: nil,
          tweet_url: nil
        }
      end

      {
        user_id_number: tweet.user_id_number,
        screen_name: tweet.user.screen_name,
        user_name: tweet.user.name,
        is_user_protected: tweet.user.protected?,
        user_profile_image_uri: tweet.user.profile_image_uri_https&.to_s,
        tweet_id_number: tweet.id_number, #=> UNIQUE
        full_text: tweet.full_text,
        is_retweet: tweet.retweet?,
        source: tweet.source, #=> "<a href=\"http://twitter.com/#!/download/ipad\" rel=\"nofollow\">Twitter for iPad</a>"
        lang: tweet.lang,
        tweeted_at: tweet.tweeted_at,
        tweet_url: tweet.url
      }
    end

    def self.to_json
      # TODO: Boolean と Integer のところは「なんちゃって JSON」になってしまうので直す
      target_tweets = base_tweets

      result = []

      target_tweets.each do |tweet|
        result << convert_tweet_object_to_hash(tweet)
      end

      result.to_json
    end

    def self.to_csv
      # batch_size は数千以上でないと意味がない
      # batch_size_number = 1000
      target_tweets = base_tweets
      # FIXME: ヘッダだけの場合にうまく受け取る方法を考える
      headers = convert_tweet_object_to_hash(target_tweets.first).keys

      # String が返る
      CSV.generate(headers: headers, force_quotes: true) do |temp_csv|
        # NOTE: batch_size を使うと order が崩れる（単位量ごとに並び替えが行われる）
        # target_tweets.find_each(batch_size: batch_size_number) do |tweet|
        target_tweets.each do |tweet|
          temp_csv << convert_tweet_object_to_hash(tweet).values
        end
      end
    end

    def self.save_file(string)
      # TODO: ファイル名を任意で決められるようにする
      Rails.root.join('tmp/radio_meyasubako_2021.csv').open('w') do |f|
        f.puts string
      end
    end

    def self.save_to_csv_file
      save_file(to_csv)
    end

    def self.save_to_json_file
      Rails.root.join('tmp/radio_meyasubako_2021.json').open('w') do |f|
        f.puts to_json
      end
    end

    def upload_file_to_storage(file_path)
      # TODO: S3 や Cloud Storage や MinIO にアップする
    end
  end
end
