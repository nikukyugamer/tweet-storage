module Operations
  class MediaUrls
    # TODO: 切り出す
    def self.output_to_file_by_list(list_id_number, target_date=Date.today)
      target_tweets = Tweet.where(list_id_number: list_id_number).where(
        'created_at >= ? AND created_at < ?',
        target_date.in_time_zone('Asia/Tokyo'),
        target_date.tomorrow.in_time_zone('Asia/Tokyo')
      )

      script_lines = []
      target_tweets.each do |tweet|
        screen_name = tweet.user.screen_name

        # TODO: 切り出す
        tweet.media.each do |medium|
          # media_url: https://pbs.twimg.com/media/FAlJ_JsUUAAgOSq.jpg
          media_url = medium.media_url_https.to_s

          # wget でダウンロードする際にファイル名を指定する（screen_name を付与したもの）
          original_filename = File.basename(URI.parse(media_url).path)
          downloaded_filepath_with_screen_name = "../downloaded_media/#{target_date.strftime('%Y%m%d')}/#{screen_name}_#{original_filename}"

          # media_url をそのまま使うと縮小版の画像になってしまうのでオリジナルサイズが得られる URL に変更する
          extension_including_dot = File.extname(media_url) # .jpg
          extension_without_dot = extension_including_dot[1..] # jpg
          url_without_extension = media_url.gsub(extension_including_dot, '') # https://pbs.twimg.com/media/FAlJ_JsUUAAgOSq
          # https://pbs.twimg.com/media/FAlJ_JsUUAAgOSq?format=jpg&name=orig
          original_size_media_url = "#{url_without_extension}?format=#{extension_without_dot}&name=orig"

          script_lines << "wget -nc -O #{downloaded_filepath_with_screen_name} '#{original_size_media_url}'"
        end
      end

      return if script_lines.empty?

      script_lines.uniq!
      script_lines.reject!(&:empty?)
      url_list_filename = "media_urls_by_list_from_cosplayers_#{target_date.strftime('%Y%m%d')}.sh"
      output_filepath = Rails.root.join("tmp/#{url_list_filename}").to_s

      File.open(output_filepath, 'w') do |f|
        f.puts "#!/bin/bash +e\n"
        f.puts script_lines
        f.puts "\nexit 0"
      end

      FileUtils.chmod(0o755, output_filepath)
    end
  end
end
