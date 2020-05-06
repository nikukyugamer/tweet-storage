module Spreadsheet
  # TODO: Refactoring
  class Gensosenkyo2020
    class << self
      def save_to_worksheet(tweets, sheet_object_key, worksheet_title:)
        # Initialize
        # worksheet[row, column] (The start number is not '0' but '1')
        current_row = 2
        worksheet = worksheet(sheet_object_key, worksheet_title: worksheet_title)

        tweets.each do |tweet|
          current_column = 1
          write_to_worksheet(worksheet, tweet, current_row, current_column)

          current_row += 1
        end

        worksheet.save
      end

      # TODO: Refactoring
      def write_to_worksheet(worksheet, tweet, current_row, current_column)
        # tweet_id
        worksheet[current_row, current_column] = tweet.id_number
        current_column += 1

        # user_name
        worksheet[current_row, current_column] = tweet.user.handle
        current_column += 1

        # user_screen_name
        worksheet[current_row, current_column] = "@#{tweet.user.screen_name}"
        current_column += 1

        # tweet_full_text
        worksheet[current_row, current_column] = tweet.full_text
        current_column += 1

        # tweet_retweet?
        worksheet[current_row, current_column] = tweet.retweet?
        current_column += 1

        # tweet_url
        worksheet[current_row, current_column] = tweet.url
        current_column += 1

        # tweet_media_exists?
        worksheet[current_row, current_column] = tweet.media?
        current_column += 1

        # TODO: Refactoring
        # tweet_public?
        worksheet[current_row, current_column] = 'true'
        current_column += 1

        # tweeted_at
        worksheet[current_row, current_column] = tweet.tweeted_at_in_japanese
      end

      # TODO: Refactoring (exclude)
      def session
        GoogleDrive::Session.from_config(Rails.root.join('config/google_api_config.json').to_s)
      end

      # TODO: Refactoring (exclude)
      def sheet_object(sheet_object_key)
        session.spreadsheet_by_key(sheet_object_key)
      end

      # TODO: Refactoring (exclude)
      def worksheet(sheet_object_key, worksheet_title:)
        sheet_object(sheet_object_key).worksheet_by_title(worksheet_title)
      end

      # TODO: Refactoring
      def gensosenkyo_2020_sheet_names
        [
          '#幻水総選挙2020',
          '#幻水総選挙運動',
          '#幻水推し台詞',
          '#幻水総選挙2020_主催より',
          '#ラジオ目安箱2020おかわり',
          '#ラジオ目安箱2020',
        ]
      end

      # TODO: Refactoring
      def gensosenkyo_2020_column_names
        [
          'tweet_id',
          'user_name',
          'user_screen_name',
          'tweet_full_text',
          'tweet_retweet?',
          'tweet_url',
          'tweet_media_exists?',
          'tweet_public?',
          'tweeted_at',
        ]
      end
    end
  end
end
