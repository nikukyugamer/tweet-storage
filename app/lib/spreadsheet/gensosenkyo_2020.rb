module Spreadsheet
  class Gensosenkyo2020
    def initialize(sheet_object_key:, worksheet_title:)
      @worksheet = worksheet(
        sheet_object_key: sheet_object_key,
        worksheet_title: worksheet_title
      )
      @cells = @worksheet.rows
    end

    def save_to_worksheet(tweets, start_row_number_on_spreadsheet:)
      current_row_number_on_spreadsheet = start_row_number_on_spreadsheet

      tweets.each do |tweet|
        start_column_number_on_spreadsheet = 1

        set_data_to_worksheet(
          tweet,
          target_row_number_on_spreadsheet: current_row_number_on_spreadsheet,
          start_column_number_on_spreadsheet: start_column_number_on_spreadsheet
        )

        current_row_number_on_spreadsheet += 1
      end

      @worksheet.save
    end

    def set_data_to_worksheet(tweet, target_row_number_on_spreadsheet:, start_column_number_on_spreadsheet:)
      # 「行」と「列」の数値は、スプレッドシート上の数値となる（1 から始まる数値）
      gensosenkyo_2020_column_names.size.times do |i|
        case start_column_number_on_spreadsheet + i
        when 1
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [[tweet.id_number]])
        when 2
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [[tweet.user.handle]])
        when 3
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [["@#{tweet.user.screen_name}"]])
        when 4
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [[tweet.full_text]])
        when 5
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [[tweet.retweet?]])
        when 6
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [[tweet.url]])
        when 7
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [[tweet.media?]])
        when 8
          # TODO: Refactoring
          # tweet_public? (or protected, deleted...)
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [['true']])
        when 9
          @worksheet.update_cells(target_row_number_on_spreadsheet, start_column_number_on_spreadsheet + i, [[tweet.tweeted_at_in_japanese]])
        end
      end
    end

    def last_valid_row_number_on_spreadsheet
      last_valid_row_number_on_spreadsheet = 1
      scanned_max_number_of_row = 10_000_000

      scanned_max_number_of_row.times do |number_of_row|
        loop_end_flag = @cells[number_of_row].present? ? false : true
        break if loop_end_flag

        last_valid_row_number_on_spreadsheet = number_of_row + 1
      end

      last_valid_row_number_on_spreadsheet
    end

    def max_tweet_id_number
      tweet_id_numbers = @cells.map {|cell| cell[0].to_i if cell[0].try(:to_i) }
      tweet_id_numbers.max
    end

    def purge_data
      start_row_number_on_spreadsheet = 2

      # ヘッダ行があるため 1 をマイナスしている
      (last_valid_row_number_on_spreadsheet - 1).times do |row_pointer|
        gensosenkyo_2020_column_names.size.times do |column_pointer|
          # 「行」と「列」の数値は、スプレッドシート上の数値となる（1 から始まる数値）
          @worksheet.update_cells(
            start_row_number_on_spreadsheet + row_pointer,
            column_pointer + 1,
            [
              [''],
            ]
          )
        end
      end

      @worksheet.save
    end

    def session
      GoogleDrive::Session.from_config(Rails.root.join('config/google_api_config.json').to_s)
    end

    def sheet_object(sheet_object_key:)
      session.spreadsheet_by_key(sheet_object_key)
    end

    def worksheet(sheet_object_key:, worksheet_title:)
      sheet_object(sheet_object_key: sheet_object_key).worksheet_by_title(worksheet_title)
    end

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

    # cf. @worksheet.num_cols, @worksheet.num_rows
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
