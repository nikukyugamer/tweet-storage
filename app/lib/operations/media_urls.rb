module Operations
  class MediaUrls
    def self.output_to_file_by_list(list_id_number, target_date=Date.today)
      # TODO: 追記された分だけを取得するためにはどの部分から追記されたかの情報がなくてはならず大変なため、いったん日付で区切る
      media_urls = Tweet.by_specific_list_with_id_number(list_id_number).where('DATE(created_at) = ?', target_date).map(&:array_of_media_urls)
      media_urls.flatten!

      filename = "media_urls_by_list_from_cosplayers_#{target_date.strftime('%Y%m%d')}.txt"
      File.open(Rails.root.join("tmp/#{filename}").to_s, 'w') do |f|
        f.puts media_urls
      end
    end
  end
end
