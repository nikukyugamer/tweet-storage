# Commands

## Use Rails console with Twitter Auth Info by ENV

```sh
$ TWITTER_CONSUMER_KEY=foo TWITTER_CONSUMER_SECRET=bar TWITTER_ACCESS_TOKEN=hoge TWITTER_ACCESS_SECRET=fuga bundle exec rails console
```

## Spreadsheet

### purge

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水推し台詞').purge_data;"
```

## By cron

### By search

- With writing to spreadsheet

```sh
# Initialize
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search('#幻水総選挙2020', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search('#幻水総選挙運動', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙運動');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search('#幻水推し台詞', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水推し台詞');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search('#幻水総選挙2020_主催より', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020_主催より');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search('#ラジオ目安箱2020おかわり', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#ラジオ目安箱2020おかわり');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search('#ラジオ目安箱2020', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#ラジオ目安箱2020');"
```

```sh
# Continuous
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.write_to_database_by_next_tweet_id_number_search_and_write_to_spreadsheet_by_db_next_tweet_id_number_search('#幻水総選挙2020', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.write_to_database_by_next_tweet_id_number_search_and_write_to_spreadsheet_by_db_next_tweet_id_number_search('#幻水総選挙運動', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙運動');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.write_to_database_by_next_tweet_id_number_search_and_write_to_spreadsheet_by_db_next_tweet_id_number_search('#幻水推し台詞', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水推し台詞');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.write_to_database_by_next_tweet_id_number_search_and_write_to_spreadsheet_by_db_next_tweet_id_number_search('#幻水総選挙2020_主催より', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020_主催より');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.write_to_database_by_next_tweet_id_number_search_and_write_to_spreadsheet_by_db_next_tweet_id_number_search('#ラジオ目安箱2020おかわり', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#ラジオ目安箱2020おかわり');"
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Batch.write_to_database_by_next_tweet_id_number_search_and_write_to_spreadsheet_by_db_next_tweet_id_number_search('#ラジオ目安箱2020', sheet_object_key: ENV['GENSOSENKYO_2020_PRODUCTION_SPREADSHEET_ID'], worksheet_title: '#ラジオ目安箱2020');"
```

- Without writing to spreadsheet

```sh
# Initialize
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.initial_write_by_search(search_query)"
```

```sh
# Continuous
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_by_next_tweet_id_number_search(search_query)"
```

### By specific user
- Only writing to database

```sh
# Initialize
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_by_specific_user_tweet(user_identify)"
```

```sh
# Continuous
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_next_tweet_by_specific_user_tweet(user_identify)"
```

### By specific list
- Only writing to database

```sh
# Initialize
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_by_list(list_identify)"
```

```sh
# Continuous
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_next_tweet_by_list(list_identify)"
```

## General

### Get user object by Twitter API

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectUser.specific_user('genso573')"
```

### Get tweet object (Single) by Twitter API

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectTweet.specific_tweets_by_tweet_id_number(303393978697535489)"
```

### Get tweet object (Multiple) by Twitter API

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectTweet.specific_tweets_by_tweet_id_numbers([303393978697535489, 1256884941989703682])"
```

### Get tweets object by specific user by Twitter API

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectTweet.specific_tweets_by_user(::TwitterApi::CollectUser.specific_user('genso573'))"
```

### Get tweets object by specific list by Twitter API

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectTweet.specific_tweets_by_list(719421755110993920)"
```

### Get list object by Twitter API

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectList.specific_list(55570485)"
```

## Gensosenkyo2020

### Get records from database
- Without retweets

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Database::ReadTweet.by_general_search('#幻水総選挙2020').size; 0;"
```

- With retweets

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Database::ReadTweet.by_with_retweet_general_search('#幻水総選挙2020').size; 0;"
```

### Get records from spreadsheet
- The last valid row number on spreadsheet

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').last_valid_row_number_on_spreadsheet; 0;"
```

- The max tweet_id_number

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').max_tweet_id_number; 0;"
```

### Get records from database and write records to spreadsheet
#### Without retweets

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_spreadsheet_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```

#### With retweets

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_spreadsheet_with_retweets_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```

### Get records from REST API, write data to database and write records to spreadsheet

#### With retweets

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```

### Spreadsheet
- max_tweet_id_number

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').max_tweet_id_number; 0;"
```

- last_valid_row_number_on_spreadsheet

```sh
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').last_valid_row_number_on_spreadsheet; 0;"
```

# FIXME: Tweet、User、List を最上位の分類として書き直したい

# よく使うコマンドを pry の書式で書く

## Twitter API を用いてオブジェクトを取得する場合（取得するだけ）

### 特定のツイート（単数）を取得する場合

```ruby
pry> ::TwitterApi::CollectTweet.specific_tweet_by_tweet_id_number(303393978697535489)
```

### 特定のツイート（複数）を取得する場合

```ruby
pry> ::TwitterApi::CollectTweet.specific_tweets_by_tweet_id_numbers([303393978697535489, 1256884941989703682])
```

### 特定のユーザを取得する場合

```ruby
pry> ::TwitterApi::CollectUser.specific_user('genso573')
```

### 特定のリストを取得する場合

```ruby
pry> ::TwitterApi::CollectList.specific_list(55570485)
```

## Twitter API を用いてユーザおよびリストに紐付いたツイートを取得する場合

### 特定のユーザに紐付いたツイートを取得する場合

```ruby
pry> ::TwitterApi::CollectTweet.specific_tweets_by_user(::TwitterApi::CollectUser.specific_user('genso573'))
```

### 特定のリストに紐付いたツイートを取得する場合

```ruby
pry> ::TwitterApi::CollectTweet.specific_tweets_by_list(719421755110993920)
```

## Twitter API を用い、データベースへの書き込みをする場合（実際に書き込みをするので注意）
- メソッドが一律でないのは、STI の type を区別しているから

### 特定のツイート（単数）を Twitter API 経由で取得してデータベースに書き込む場合

```ruby
pry> ::Operations::Gensosenkyo2020::Database.write_tweet_by_specific_tweet_id_number(1234567890)
```

### 特定のツイート（複数）を Twitter API 経由で取得してデータベースに書き込む場合

```ruby
pry> ::Operations::Gensosenkyo2020::Database.write_tweets_by_specific_tweet_id_numbers([12345, 55555, 98765])
```

### 特定のユーザを Twitter API 経由で取得してデータベースに書き込む場合

```ruby
pry> ::Operations::Gensosenkyo2020::Database.write_specific_user_record('genso573')
```

### 特定のリストを Twitter API 経由で取得してデータベースに書き込む場合

```ruby
pry> ::Operations::Gensosenkyo2020::Database.write_specific_list_record(719421755110993920)
```

### 特定のユーザに紐付いたツイートを Twitter API 経由で取得してデータベースに書き込む場合

```ruby
pry> ::Operations::Gensosenkyo2020::Database.write_by_specific_user_tweet('genso573')
```

### 特定のリストに紐付いたツイートを Twitter API 経由で取得してデータベースに書き込む場合

- 初回

```ruby
pry> ::Operations::Gensosenkyo2020::Database.write_by_list(719421755110993920)
```

- 続き

```ruby
pry> ::Operations::Gensosenkyo2020::Database.write_next_tweet_by_list(719421755110993920)
```

# データベースから値を取り出すときによく使う書き方

## 特定のユーザに紐付いたツイート（複数になる）をすべて取得する

```ruby
pry> Tweet.by_specific_user_with_id_number(368700197)
```

## 特定のリストに紐付いたツイート（複数になる）をすべて取得する

```ruby
pry> Tweet.by_specific_list_with_id_number(719421755110993920)
```

## 特定のツイートに結び付けられているユーザオブジェクト（一つになる）を取得する

```ruby
pry> Tweet.find_by(id_number: 1261204672087457793).user
```

## 特定のツイートに結び付けられているリストオブジェクト（一つになる）を取得する
- リストをもとにして当該ツイートを取得したことが必要

```ruby
pry> ByListTweet.find_by(id_number: 719421755110993920).list
```

# スクリプト

## リストのツイートに含まれる media の URL を配列で取得し wget する。

```ruby
target_list = List.find_(name: 'FOOBAR')
media_urls = target_list.tweets.map {|tweet| tweet.array_of_media_urls }
media_urls.flatten!

media_urls.each do |media_url|
  command = "wget #{media_url}"
  `#{command}`
end
```
