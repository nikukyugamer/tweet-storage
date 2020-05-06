|    |master|development|
|:--:|:----:|:---------:|
|CircleCI|[![TweetStorage (master)](https://circleci.com/gh/corselia/tweet-storage/tree/master.svg?style=svg)](https://circleci.com/gh/corselia/tweet-storage)|[![TweetStorage (development)](https://circleci.com/gh/corselia/tweet-storage/tree/development.svg?style=svg)](https://circleci.com/gh/corselia/tweet-storage)|
|GitHub Actions|![GitHub Actions Status (master)](https://github.com/corselia/tweet-storage/workflows/Tweet%20Storage/badge.svg?branch=master)|![GitHub Actions Status (development)](https://github.com/corselia/tweet-storage/workflows/Tweet%20Storage/badge.svg?branch=development)|

# TweetStorage
- Tweet Storage

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
