module TwitterApi
  class CollectList
    extend TwitterClient

    class << self
      def specific_list(list_identify, options = {})
        client.list(list_identify, options)
      end
    end
  end
end
