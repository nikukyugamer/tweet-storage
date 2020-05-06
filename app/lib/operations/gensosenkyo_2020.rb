module Operations
  class Gensosenkyo2020
    class << self
      def initial_execute_by_search(search_query)
        # 初期化して全ツイートを取得する
        tweets = TwitterApi::CollectTweet.all_by_search(search_query)
        TwitterApi::SaveTweetToDb.execute_by_search_word_tweet(search_query, tweets)

        # Spreadsheetに書き込む
        target_tweets = BySearchWordTweet.where(search_word: search_query).remove_duplicated.remove_retweet.order_by_id_number_asc

        sheet_object_key = ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'] || Rails.application.credentials[:spreadsheet_id]
        Spreadsheet::Gensosenkyo2020.save_to_worksheet(target_tweets, sheet_object_key, worksheet_title: search_query)
      end

      def write_to_raw_log_by_search(search_query)
        # Tweet は DB に格納されているものとする
        target_tweets = BySearchWordTweet.where(search_word: search_query).remove_duplicated.order_by_id_number_asc

        sheet_object_key = ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'] || Rails.application.credentials[:spreadsheet_id_for_log]
        Spreadsheet::Gensosenkyo2020.save_to_worksheet(target_tweets, sheet_object_key, worksheet_title: search_query)
      end
    end
  end
end
