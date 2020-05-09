module TwitterApi
  class CollectUser
    extend TwitterClient

    class << self
      def search_users(search_query)
        client.user_search(search_query)
      end

      def specific_user(user_identify)
        client.user(user_identify)
      end
    end
  end
end
