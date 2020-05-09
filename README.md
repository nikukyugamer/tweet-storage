|    |master|development|
|:--:|:----:|:---------:|
|CircleCI|[![TweetStorage (master)](https://circleci.com/gh/corselia/tweet-storage/tree/master.svg?style=svg)](https://circleci.com/gh/corselia/tweet-storage)|[![TweetStorage (development)](https://circleci.com/gh/corselia/tweet-storage/tree/development.svg?style=svg)](https://circleci.com/gh/corselia/tweet-storage)|
|GitHub Actions|![GitHub Actions Status (master)](https://github.com/corselia/tweet-storage/workflows/Tweet%20Storage/badge.svg?branch=master)|![GitHub Actions Status (development)](https://github.com/corselia/tweet-storage/workflows/Tweet%20Storage/badge.svg?branch=development)|

# TweetStorage
- Tweet Storage

# Rate limits

## Standard search API
- 180 Requests / 15-min window (user auth)
- 12 Requests / 1-min window (user auth)
- 1 Request / 5-sec window (user auth)
  - https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets

# Standard search operators
- https://developer.twitter.com/en/docs/tweets/rules-and-filtering/overview/standard-operators

| Operator                          | Finds Tweets...                                                                               |
|-----------------------------------|-----------------------------------------------------------------------------------------------|
| watching now                      | containing both “watching” and “now”. This is the default operator.                           |
| “happy hour”                      | containing the exact phrase “happy hour”.                                                     |
| love OR hate                      | containing either “love” or “hate” (or both).                                                 |
| beer -root                        | containing “beer” but not “root”.                                                             |
| #haiku                            | containing the hashtag “haiku”.                                                               |
| from:interior                     | sent from Twitter account “interior”.                                                         |
| list:NASA/astronauts-in-space-now | sent from a Twitter account in the NASA list astronauts-in-space-now                          |
| to:NASA                           | a Tweet authored in reply to Twitter account “NASA”.                                          |
| @NASA                             | mentioning Twitter account “NASA”.                                                            |
| politics filter:safe              | containing “politics” with Tweets marked as potentially sensitive removed.                    |
| puppy filter:media                | containing “puppy” and an image or video.                                                     |
| puppy -filter:retweets            | containing “puppy”, filtering out retweets                                                    |
| puppy filter:native_video         | containing “puppy” and an uploaded video, Amplify video, Periscope, or Vine.                  |
| puppy filter:periscope            | containing “puppy” and a Periscope video URL.                                                 |
| puppy filter:vine                 | containing “puppy” and a Vine.                                                                |
| puppy filter:images               | containing “puppy” and links identified as photos, including third parties such as Instagram. |
| puppy filter:twimg                | containing “puppy” and a pic.twitter.com link representing one or more photos.                |
| hilarious filter:links            | containing “hilarious” and linking to URL.                                                    |
| puppy url:amazon                  | containing “puppy” and a URL with the word “amazon” anywhere within it.                       |
| superhero since:2015-12-21        | containing “superhero” and sent since date “2015-12-21” (year-month-day).                     |
| puppy until:2015-12-21            | containing “puppy” and sent before the date “2015-12-21”.                                     |
| movie -scary :)                   | containing “movie”, but not “scary”, and with a positive attitude.                            |
| flight :(                         | containing “flight” and with a negative attitude.                                             |
| traffic ?                         | containing “traffic” and asking a question.                                                   |

# Commands

## Gensosenkyo2020

### Get records from database
- Without retweets

```sh
$ bundle exec rails runner "pp ::Database::ReadTweet.by_general_search('#幻水総選挙2020').size; 0;"
```

- With retweets

```sh
$ bundle exec rails runner "pp ::Database::ReadTweet.by_with_retweet_general_search('#幻水総選挙2020').size; 0;"
```

### Get records from spreadsheet
- The last valid row number on spreadsheet

```sh
$ bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').last_valid_row_number_on_spreadsheet; 0;"
```

- The max tweet_id_number

```sh
$ bundle exec rails runner "pp ::Spreadsheet::Gensosenkyo2020.new(sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: '#幻水総選挙2020').max_tweet_id_number; 0;"
```

### Get records from database and write records to spreadsheet
#### Without retweets

```sh
$ bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_spreadsheet_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```

#### With retweets

```sh
$ bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_spreadsheet_with_retweets_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```

### Get records from REST API, write data to database and write records to spreadsheet

#### With retweets

```sh
$ bundle exec rails runner "['#幻水総選挙2020', '#幻水総選挙運動', '#幻水推し台詞', '#幻水総選挙2020_主催より', '#ラジオ目安箱2020おかわり', '#ラジオ目安箱2020'].each {|q| ::Operations::Gensosenkyo2020::Batch.initial_write_to_database_and_spreadsheet_by_search(q, sheet_object_key: ENV['GENSOSENKYO_2020_DEVELOPMENT_SPREADSHEET_ID'], worksheet_title: q) }"
```
