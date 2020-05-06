require 'rails_helper'

RSpec.describe BySearchWordTweet, type: :model do
  describe "'search_word' column" do
    it 'If not exist, a validation error occurs' do
      by_search_word_tweet = BySearchWordTweet.new(
        id_number: 54321,
        full_text: 'Hello, World!',
        serialized_object: {}
      )
      by_search_word_tweet.user = FactoryBot.build(:user)

      by_search_word_tweet.valid?
      expect(by_search_word_tweet.errors.messages).not_to be_empty
    end
  end
end
