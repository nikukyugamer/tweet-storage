# TODO: Refactoring (Commonization)
module Operations
  module Gensosenkyo2020
    class Database
      class << self
        # APIでのツイート取得を伴う
        # データベースへの書き込みを伴う
        # データベースに収められているツイートの最新以降のツイートをタイムラインから取得し、DBに書き込む
        # その際、対象ツイート数が 101 以上の場合は、すべてを取得するまでループする
        # 最も使われるメソッド
        def write_by_next_tweet_id_number_search(search_query)
          tweets = TwitterApi::CollectTweet.continue_from_next_tweet_id_number_with_loop_by_search(search_query)
          ::Database::SaveTweet.by_search_word_tweet(search_query, tweets)
        end

        # APIでのツイート取得を伴う
        # データベースへの書き込みを伴う
        # 初めてのツイート取得からのデータベース格納の際に用いるメソッド
        def initial_write_by_search(search_query)
          tweets = TwitterApi::CollectTweet.all_by_search(search_query)
          ::Database::SaveTweet.by_search_word_tweet(search_query, tweets)
        end

        # APIでのツイート取得を伴う
        # データベースへの書き込みを伴う
        # タイムライン全体からツイートを取得し、DBに書き込む
        # 取得ツイートの上限数は 100 なので cron 目的にはあまり使われない
        # API の使用量を明示的に抑制できる
        def write_by_general_search(search_query)
          tweets = TwitterApi::CollectTweet.by_search(search_query)
          ::Database::SaveTweet.by_search_word_tweet(search_query, tweets)
        end
      end
    end
  end
end
