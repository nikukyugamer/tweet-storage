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

        # 初期化用
        def write_by_list(list_identify, options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
          target_list_from_api = TwitterApi::CollectList.specific_list(list_identify)
          tweets = TwitterApi::CollectTweet.all_by_specific_list(list_identify, options)

          ::Database::SaveTweet.by_list_tweet(target_list_from_api, tweets)
        end

        # 2回目以降用
        def write_next_tweet_by_list(list_identify, options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
          target_list_from_api      = TwitterApi::CollectList.specific_list(list_identify)
          target_list_from_db       = List.find_by(id_number: target_list_from_api.id)
          max_id_number_tweet_in_db = target_list_from_db.tweets.max_id_number
          options = options.merge({ since_id: max_id_number_tweet_in_db })

          # データベースに記録する情報は最新の情報にしたいので、API から取得した情報を用いる
          tweets = TwitterApi::CollectTweet.all_by_specific_list(list_identify, options)
          ::Database::SaveTweet.by_list_tweet(target_list_from_api, tweets)
        end

        # 初期化用
        def write_by_specific_user_tweet(user_identify, options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
          tweets = TwitterApi::CollectTweet.all_by_specific_user(user_identify, options)
          ::Database::SaveTweet.by_specific_user_tweet(tweets)
        end

        # 2回目以降用
        def write_next_tweet_by_specific_user_tweet(user_identify, options = { count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
          target_user_from_api      = TwitterApi::CollectUser.specific_user(user_identify)
          target_tweets_from_db     = Tweet.by_specific_user(target_user_from_api.id)
          max_id_number_tweet_in_db = target_tweets_from_db.max_id_number
          options = options.merge({ since_id: max_id_number_tweet_in_db })

          # データベースに記録する情報は最新の情報にしたいので、API から取得した情報を用いる
          tweets = TwitterApi::CollectTweet.all_by_specific_user(user_identify, options)
          ::Database::SaveTweet.by_specific_user_tweet(tweets)
        end
      end
    end
  end
end
