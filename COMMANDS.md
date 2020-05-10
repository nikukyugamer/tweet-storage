# Commands

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
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.initial_write_by_search(search_query)
```

```sh
# Continuous
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_by_next_tweet_id_number_search(search_query)
```

### By specific user
- Only writing to database

```sh
# Initialize
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_by_specific_user_tweet(user_identify)
```

```sh
# Continuous
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_next_tweet_by_specific_user_tweet(user_identify)
```

### By specific list
- Only writing to database

```sh
# Initialize
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_by_list(list_identify)
```

```sh
# Continuous
$ RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rails runner "Operations::Gensosenkyo2020::Database.write_next_tweet_by_list(list_identify)
```

## General

### Get user object

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectUser.specific_user('genso573')"
```

### Get tweet object (Single)

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectTweet.specific_tweets_by_tweet_id_number(303393978697535489)"
```

### Get tweet object (Multiple)

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectTweet.specific_tweets_by_tweet_id_numbers([303393978697535489, 1256884941989703682])"
```

### Get tweets object by specific user

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectTweet.specific_tweets_by_user(::TwitterApi::CollectUser.specific_user('genso573'))"
```

### Get tweets object by specific list

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectTweet.specific_tweets_by_list(719421755110993920)"
```

### Get list object

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::TwitterApi::CollectList.specific_list(55570485)"
```

## Gensosenkyo2020

### Get records from database
- Without retweets

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Database::ReadTweet.by_general_search('#幻水総選挙2020').size; 0;"
```

- With retweets

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Database::ReadTweet.by_with_retweet_general_search('#幻水総選挙2020').size; 0;"
```

### Get records from spreadsheet
- The last valid row number on spreadsheet

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').last_valid_row_number_on_spreadsheet; 0;"
```

- The max tweet_id_number

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').max_tweet_id_number; 0;"
```

### Get records from database and write records to spreadsheet
#### Without retweets

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_spreadsheet_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```

#### With retweets

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_spreadsheet_with_retweets_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```

### Get records from REST API, write data to database and write records to spreadsheet

#### With retweets

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```

### Spreadsheet
- max_tweet_id_number

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').max_tweet_id_number; 0;"
```

- last_valid_row_number_on_spreadsheet

```sh
$ /home/ubuntu/.rbenv/shims/bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').last_valid_row_number_on_spreadsheet; 0;"
```
