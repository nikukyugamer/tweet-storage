# FIXME: Refactoring (Commonization)
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
        def write_by_list(list_identify, options = { tweet_mode: 'extended', count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
          target_list_from_api = TwitterApi::CollectList.specific_list(list_identify)
          tweets = TwitterApi::CollectTweet.all_by_specific_list(list_identify, options)

          ::Database::SaveTweet.by_list_tweet(target_list_from_api, tweets)
        end

        # 2回目以降用
        def write_next_tweet_by_list(list_identify, options = { tweet_mode: 'extended', count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
          # データベースに記録する情報は最新の情報にしたいので、API から取得した情報を用いる
          target_list_from_api = TwitterApi::CollectList.specific_list(list_identify)
          max_id_number_tweet_in_db = Tweet.by_specific_list_with_id_number(target_list_from_api.id).max_id_number
          options = options.merge({ since_id: max_id_number_tweet_in_db })

          tweets = TwitterApi::CollectTweet.all_by_specific_list(list_identify, options)
          ::Database::SaveTweet.by_list_tweet(target_list_from_api, tweets)
        end

        # 初期化用
        def write_by_specific_user_tweet(user_identify, options = { tweet_mode: 'extended', count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
          tweets = TwitterApi::CollectTweet.all_by_specific_user(user_identify, options)
          ::Database::SaveTweet.by_specific_user_tweet(tweets)
        end

        # 2回目以降用
        def write_next_tweet_by_specific_user_tweet(user_identify, options = { tweet_mode: 'extended', count: 200, since_id: 1, max_id: 9_000_000_000_000_000_000 })
          target_user_from_api  = TwitterApi::CollectUser.specific_user(user_identify)
          target_tweets_from_db = Tweet.by_specific_user_with_id_number(target_user_from_api.id)
          max_id_number_tweet_in_db = target_tweets_from_db.max_id_number
          options = options.merge({ since_id: max_id_number_tweet_in_db })

          # データベースに記録する情報は最新の情報にしたいので、API から取得した情報を用いる
          tweets = TwitterApi::CollectTweet.all_by_specific_user(user_identify, options)
          ::Database::SaveTweet.by_specific_user_tweet(tweets)
        end

        # 特定のユーザ（単数）のレコードを追加する
        # TODO: 元のメソッドと併せて、options の追加
        def write_specific_user_record(user_identify)
          specific_user = TwitterApi::CollectUser.specific_user(user_identify)
          ::Database::SaveUser.create(specific_user)
        end

        # 一つだけであることに注意する
        # 取得に失敗した場合には例外が返る
        def write_tweet_by_specific_tweet_id_number(id_number)
          tweet = ::TwitterApi::CollectTweet.specific_tweet_by_tweet_id_number(id_number)
          ::Database::SaveTweet.by_specific_id_tweets(tweet)
        end

        # 複数を一度に（一回のAPI消費で）取得する
        # 取得に失敗したツイートに対しては空が返る（例外は返らない）
        def write_tweets_by_specific_tweet_id_numbers(*id_numbers)
          tweets = ::TwitterApi::CollectTweet.specific_tweets_by_tweet_id_numbers(id_numbers)
          ::Database::SaveTweet.by_specific_id_tweets(tweets)
        end

        # 特定のリストのレコードを追加する
        def write_specific_list_record(id_number)
          specific_list = ::TwitterApi::CollectList.specific_list(id_number)
          ::Database::SaveList.create(specific_list)
        end
      end
    end
  end
end
