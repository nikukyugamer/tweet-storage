# TODO: Refactoring
module Operations
  module Gensosenkyo2020
    class Batch
      class << self
        # APIでのツイート取得を伴う
        # データベースに収められているツイートの最新以降のツイートを API でタイムラインから取得し、DBに書き込む
        # その際、対象ツイート数が 101 以上の場合は、すべてを取得するまでループする
        # その後、取得したツイートを、スプレッドシートの最終行の次の行から追記する
        # 追記に際しては、重複IDを除外したデータをDBから取得して、追記する
        # 最も使われるメソッド
        def write_to_database_by_next_tweet_id_number_search_and_write_to_spreadsheet_by_db_next_tweet_id_number_search(
          search_query,
          sheet_object_key: nil,
          worksheet_title: nil
        )
          ::Operations::Gensosenkyo2020::Database.write_by_next_tweet_id_number_search(search_query)
          ::Operations::Gensosenkyo2020::Spreadsheet
            .add_by_db_next_tweet_id_number_search(
              search_query,
              sheet_object_key: sheet_object_key,
              worksheet_title: worksheet_title
            )
        end

        # APIでのツイート取得を伴う
        # タイムライン全体から API で最新の 100 ツイートを検索し、DBに書き込み、スプレッドシートの最終行の次の行から追記する
        # APIの使用量を明示的に抑制できる
        # cron で継続的に使われることはあまりなく、試験的に使われるのが主な用途であろうか
        def write_to_database_by_general_search_and_write_to_spreadsheet_by_general_search(
          search_query,
          sheet_object_key: nil,
          worksheet_title: nil
        )
          ::Operations::Gensosenkyo2020::Database.write_by_general_search(search_query)
          ::Operations::Gensosenkyo2020::Spreadsheet.add_by_db_general_search(
            search_query,
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )
        end

        # API でのツイート取得を伴う
        # スプレッドシートを全削除して、データを API で初期取得（全取得）し直して、スプレッドシートに書き込む
        # 初期の初期で実行されるメソッド
        # Rate limits を警戒してインターバルを取っているため、実行には時間がかかる
        def initial_write_to_database_and_spreadsheet_by_search(
          search_query,
          sheet_object_key: nil,
          worksheet_title: nil
        )
          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )
          ::Operations::Gensosenkyo2020::Database.initial_write_by_search(search_query)
          target_spreadsheet.purge_data
          ::Operations::Gensosenkyo2020::Spreadsheet.initial_write_by_general_search(
            search_query,
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )
        end

        # API でのツイート取得は伴わない
        # データは DB にすでに格納されているものを用いる
        # スプレッドシートを全削除して、データを DB から初期取得（全取得）し直して、スプレッドシートに書き込む
        # データは DB にあり、改めてスプレッドシートを初期化して書き込みしたい場合に用いるメソッド
        def initial_write_to_spreadsheet_by_search(
          search_query,
          sheet_object_key: nil,
          worksheet_title: nil
        )
          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )
          target_spreadsheet.purge_data
          ::Operations::Gensosenkyo2020::Spreadsheet.initial_write_by_general_search(
            search_query,
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )
        end

        # API でのツイート取得は伴わない
        # データは DB にすでに格納されているものを用いる
        # スプレッドシートを全削除して、データを DB から初期取得（全取得）し直して、スプレッドシートに書き込む
        # データは DB にあり、改めてスプレッドシートを初期化して書き込みしたい場合に用いるメソッド
        # データには retweets を含む
        def initial_write_to_spreadsheet_with_retweets_by_search(
          search_query,
          sheet_object_key: nil,
          worksheet_title: nil
        )
          target_spreadsheet = ::Spreadsheet::Gensosenkyo2020.new(
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )
          target_spreadsheet.purge_data
          ::Operations::Gensosenkyo2020::Spreadsheet.initial_write_by_with_retweets_general_search(
            search_query,
            sheet_object_key: sheet_object_key,
            worksheet_title: worksheet_title
          )
        end
      end
    end
  end
end
