module Operations
  class MediaUrls
    # FIXME: メソッドの分割
    def self.output_to_file_by_list(list_id_number, target_date=Date.today)
      # TODO: 追記された分だけを取得するためにはどの部分から追記されたかの情報がなくてはならず大変なため、いったん日付で区切る
      # FIXME: タイムゾーンがハードコーディングされている
      media_urls = Tweet.where(list_id_number: list_id_number).where(
        'created_at >= ? AND created_at < ?',
        target_date.in_time_zone('Asia/Tokyo'),
        target_date.tomorrow.in_time_zone('Asia/Tokyo')
      ).map(&:array_of_media_urls)
      media_urls.flatten!

      unless media_urls.nil?
        media_urls.uniq!

        filename = "media_urls_by_list_from_cosplayers_#{target_date.strftime('%Y%m%d')}.txt"
        File.open(Rails.root.join("tmp/#{filename}").to_s, 'w') do |f|
          f.puts media_urls
        end
      end
    end
  end
end
