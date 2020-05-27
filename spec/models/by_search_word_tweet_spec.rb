require 'rails_helper'

RSpec.describe BySearchWordTweet, type: :model do
  let(:by_search_word_tweet) do
    build(:tweet, :by_search_word)
  end

  describe "'search_word' column" do
    it 'If not exist, a validation error occurs' do
      by_search_word_tweet.search_word = nil

      by_search_word_tweet.valid?
      expect(by_search_word_tweet.errors.messages).not_to be_empty
    end

    it 'If exists, valid' do
      by_search_word_tweet.valid?
      expect(by_search_word_tweet.errors.messages).to be_empty
    end
  end
end
