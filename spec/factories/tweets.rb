FactoryBot.define do
  factory :tweet do
    association :user
    id_number { 1_265_358_590_270_996_483}
    full_text { "新チャプター『Silent Hill』に登場する\n◆新殺人鬼エクセキューショナー\n◆新生存者シェリル・メイソン\n◆新マップ「サイレントヒル: ミッドウィッチ小学校」\nをご紹介します！\n\n詳しくはこちら: https://t.co/alLCeZ3Bgi\n#DeadbyDaylight #DbD #新キラー #ピラミッドヘッド https://t.co/fJOdFslrBa" }
    serialized_object {  "{\"created_at\":\"Tue May 26 19:06:11 +0000 2020\",\"id\":1265358590270996483,\"id_str\":\"1265358590270996483\",\"full_text\":\"新チャプター『Silent Hill』に登場する\\n◆新殺人鬼エクセキューショナー\\n◆新生存者シェリル・メイソン\\n◆新マップ「サイレントヒル: ミッドウィッチ小学校」\\nをご紹介します！\\n\\n詳しくはこちら: https://t.co/alLCeZ3Bgi\\n#DeadbyDaylight #DbD #新キラー #ピラミッドヘッド https://t.co/fJOdFslrBa\",\"truncated\":false,\"display_text_range\":[0,162],\"entities\":{\"hashtags\":[{\"text\":\"DeadbyDaylight\",\"indices\":[126,141]},{\"text\":\"DbD\",\"indices\":[142,146]},{\"text\":\"新キラー\",\"indices\":[147,152]},{\"text\":\"ピラミッドヘッド\",\"indices\":[153,162]}],\"symbols\":[],\"user_mentions\":[],\"urls\":[{\"url\":\"https://t.co/alLCeZ3Bgi\",\"expanded_url\":\"https://bit.ly/36z3IZa\",\"display_url\":\"bit.ly/36z3IZa\",\"indices\":[102,125]}],\"media\":[{\"id\":1265358587053977603,\"id_str\":\"1265358587053977603\",\"indices\":[163,186],\"media_url\":\"http://pbs.twimg.com/media/EY907kbXsAMkMWR.jpg\",\"media_url_https\":\"https://pbs.twimg.com/media/EY907kbXsAMkMWR.jpg\",\"url\":\"https://t.co/fJOdFslrBa\",\"display_url\":\"pic.twitter.com/fJOdFslrBa\",\"expanded_url\":\"https://twitter.com/DeadbyBHVR_JP/status/1265358590270996483/photo/1\",\"type\":\"photo\",\"sizes\":{\"thumb\":{\"w\":150,\"h\":150,\"resize\":\"crop\"},\"medium\":{\"w\":1200,\"h\":675,\"resize\":\"fit\"},\"small\":{\"w\":680,\"h\":383,\"resize\":\"fit\"},\"large\":{\"w\":1920,\"h\":1080,\"resize\":\"fit\"}}}]},\"extended_entities\":{\"media\":[{\"id\":1265358587053977603,\"id_str\":\"1265358587053977603\",\"indices\":[163,186],\"media_url\":\"http://pbs.twimg.com/media/EY907kbXsAMkMWR.jpg\",\"media_url_https\":\"https://pbs.twimg.com/media/EY907kbXsAMkMWR.jpg\",\"url\":\"https://t.co/fJOdFslrBa\",\"display_url\":\"pic.twitter.com/fJOdFslrBa\",\"expanded_url\":\"https://twitter.com/DeadbyBHVR_JP/status/1265358590270996483/photo/1\",\"type\":\"photo\",\"sizes\":{\"thumb\":{\"w\":150,\"h\":150,\"resize\":\"crop\"},\"medium\":{\"w\":1200,\"h\":675,\"resize\":\"fit\"},\"small\":{\"w\":680,\"h\":383,\"resize\":\"fit\"},\"large\":{\"w\":1920,\"h\":1080,\"resize\":\"fit\"}}}]},\"source\":\"\\u003ca href=\\\"https://sproutsocial.com\\\" rel=\\\"nofollow\\\"\\u003eSprout Social\\u003c/a\\u003e\",\"in_reply_to_status_id\":null,\"in_reply_to_status_id_str\":null,\"in_reply_to_user_id\":null,\"in_reply_to_user_id_str\":null,\"in_reply_to_screen_name\":null,\"user\":{\"id\":1130828992238432256,\"id_str\":\"1130828992238432256\",\"name\":\"【公式】Dead by Daylight\",\"screen_name\":\"DeadbyBHVR_JP\",\"location\":\"エンティティの森\",\"description\":\"#DeadbyDaylight は @Behaviour が開発した非対称マルチプレイホラーゲームです。PC/PS4/Switchで好評発売中！ #デッドバイデイライト #DbD お問い合わせ先: https://t.co/jS0JyjQZ7b\",\"url\":\"https://t.co/W9PnqkML4W\",\"entities\":{\"url\":{\"urls\":[{\"url\":\"https://t.co/W9PnqkML4W\",\"expanded_url\":\"https://deadbydaylight.com\",\"display_url\":\"deadbydaylight.com\",\"indices\":[0,23]}]},\"description\":{\"urls\":[{\"url\":\"https://t.co/jS0JyjQZ7b\",\"expanded_url\":\"https://forum.deadbydaylight.com/ja/discussion/152514/\",\"display_url\":\"forum.deadbydaylight.com/ja/discussion/…\",\"indices\":[99,122]}]}},\"protected\":false,\"followers_count\":112336,\"friends_count\":23,\"listed_count\":563,\"created_at\":\"Tue May 21 13:33:36 +0000 2019\",\"favourites_count\":24,\"utc_offset\":null,\"time_zone\":null,\"geo_enabled\":false,\"verified\":false,\"statuses_count\":529,\"lang\":null,\"contributors_enabled\":false,\"is_translator\":false,\"is_translation_enabled\":false,\"profile_background_color\":\"F5F8FA\",\"profile_background_image_url\":null,\"profile_background_image_url_https\":null,\"profile_background_tile\":false,\"profile_image_url\":\"http://pbs.twimg.com/profile_images/1132489859908554753/_H9yy6bS_normal.jpg\",\"profile_image_url_https\":\"https://pbs.twimg.com/profile_images/1132489859908554753/_H9yy6bS_normal.jpg\",\"profile_banner_url\":\"https://pbs.twimg.com/profile_banners/1130828992238432256/1590016548\",\"profile_link_color\":\"1DA1F2\",\"profile_sidebar_border_color\":\"C0DEED\",\"profile_sidebar_fill_color\":\"DDEEF6\",\"profile_text_color\":\"333333\",\"profile_use_background_image\":true,\"has_extended_profile\":true,\"default_profile\":true,\"default_profile_image\":false,\"following\":false,\"follow_request_sent\":false,\"notifications\":false,\"translator_type\":\"none\"},\"geo\":null,\"coordinates\":null,\"place\":null,\"contributors\":null,\"is_quote_status\":false,\"retweet_count\":21361,\"favorite_count\":29259,\"favorited\":false,\"retweeted\":false,\"possibly_sensitive\":false,\"possibly_sensitive_appealable\":false,\"lang\":\"ja\",\"text\":\"新チャプター『Silent Hill』に登場する\\n◆新殺人鬼エクセキューショナー\\n◆新生存者シェリル・メイソン\\n◆新マップ「サイレントヒル: ミッドウィッチ小学校」\\nをご紹介します！\\n\\n詳しくはこちら: https://t.co/alLCeZ3Bgi\\n#DeadbyDaylight #DbD #新キラー #ピラミッドヘッド https://t.co/fJOdFslrBa\"}" }
    type { 'BySpecificIdTweet' }
    user_id_number { user.id_number }

    trait :by_list do
      initialize_with { ByListTweet.new(attributes) }

      type { 'ByListTweet' }
      list { list }
    end

    trait :by_search_word do
      initialize_with { BySearchWordTweet.new(attributes) }

      type { 'BySearchWordTweet' }
      search_word { '検索文字列検索文字列' }
    end

    trait :by_specific_id do
      initialize_with { BySpecificIdTweet.new(attributes) }

      type { 'BySpecificIdTweet' }
    end

    trait :by_specific_user do
      initialize_with { BySpecificUserTweet.new(attributes) }

      type { 'BySpecificUserTweet' }
    end
  end
end
