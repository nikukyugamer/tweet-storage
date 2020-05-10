# TODO: Refactoring (Commonization)
module Operations
  module Gensosenkyo2020
    class Spreadsheet
      class << self
        # Twitter API は使用しない
        # スプレッドシートにある最大の tweet_id_number の次のツイートから、データベースを探し、それをスプレッドシートの有効最終行の次の行から書き込む
        # 最も使われるメソッド
        def add_by_db_next_tweet_id_number_search(search_query, sheet_object_key: nil, worksheet_title: nil)
          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )

          # 'tweets' from database
          target_tweets = ::Database::ReadTweet.by_next_tweet_id_number_search(
            search_query,
            target_spreadsheet.max_tweet_id_number
          )

          target_spreadsheet.save_to_worksheet(
            target_tweets,
            start_row_number_on_spreadsheet: target_spreadsheet.last_valid_row_number_on_spreadsheet + 1
          )
        end

        # Twitter API は使用しない
        # スプレッドシートにある最大の tweet_id_number の次のツイートから、RT込みで、データベースを探し、それをスプレッドシートの有効最終行の次の行から書き込む
        # RT込みで書き込みたい場合に最も使われるメソッド
        def add_by_with_retweet_db_next_tweet_id_number_search(search_query, sheet_object_key: nil, worksheet_title: nil)
          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )

          # 'tweets' from database
          target_tweets = ::Database::ReadTweet.by_with_retweet_next_tweet_id_number_search(
            search_query,
            target_spreadsheet.max_tweet_id_number
          )

          target_spreadsheet.save_to_worksheet(
            target_tweets,
            start_row_number_on_spreadsheet: target_spreadsheet.last_valid_row_number_on_spreadsheet + 1
          )
        end

        # Twitter API は使用しない
        # データベースにあるすべてのツイートを、RTは除外して、2行目から書き込む（上書きすることになる）
        # 初期化時に用いる
        def initial_write_by_general_search(search_query, sheet_object_key:, worksheet_title:)
          target_tweets = ::Database::ReadTweet.by_general_search(search_query)
          # TODO: Refactoring (The header row number is '1')
          last_valid_row_number_on_spreadsheet = 1

          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )

          target_spreadsheet.save_to_worksheet(
            target_tweets,
            start_row_number_on_spreadsheet: last_valid_row_number_on_spreadsheet + 1
          )
        end

        # Twitter API は使用しない
        # データベースにあるすべてのツイートを、RTも含めて、2行目から書き込む（上書きすることになる）
        # 初期化時に用いる
        def initial_write_by_with_retweets_general_search(search_query, sheet_object_key:, worksheet_title:)
          target_tweets = ::Database::ReadTweet.by_with_retweet_general_search(search_query)
          # TODO: Refactoring (The header row number is '1')
          last_valid_row_number_on_spreadsheet = 1

          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )

          target_spreadsheet.save_to_worksheet(
            target_tweets,
            start_row_number_on_spreadsheet: last_valid_row_number_on_spreadsheet + 1
          )
        end

        # Twitter API は使用しない
        # データベースのすべてのデータを、スプレッドシートの有効最終行の次の行から書き込む
        # 重複追記の可能性があるので、使用頻度は低い
        def add_by_db_general_search(search_query, sheet_object_key: nil, worksheet_title: nil)
          target_tweets = ::Database::ReadTweet.by_general_search(search_query)
          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )

          target_spreadsheet.save_to_worksheet(
            target_tweets,
            start_row_number_on_spreadsheet: target_spreadsheet.last_valid_row_number_on_spreadsheet + 1
          )
        end

        # Twitter API は使用しない
        # データベースのすべてのデータを、RTも含めて、スプレッドシートの有効最終行の次の行から書き込む
        # 重複追記の可能性があるので、使用頻度は低い
        def add_by_with_retweet_db_general_search(search_query, sheet_object_key: nil, worksheet_title: nil)
          target_tweets = ::Database::ReadTweet.by_with_retweet_general_search(search_query)
          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )

          target_spreadsheet.save_to_worksheet(
            target_tweets,
            start_row_number_on_spreadsheet: target_spreadsheet.last_valid_row_number_on_spreadsheet + 1
          )
        end
      end
    end
  end
end
