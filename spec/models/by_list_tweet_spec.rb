require 'rails_helper'

RSpec.describe ByListTweet, type: :model do
  describe "'list_id_number' column" do
    it 'If not exist, a validation error occurs' do
      by_list_tweet = ByListTweet.new(
        user_id: 12345,
        id_number: 54321,
        full_text: 'Hello, World!',
        serialized_object: {},
        list_name: 'Awesome List',
        list_serialized_object: {}
      )

      by_list_tweet.valid?
      expect(by_list_tweet.errors.messages).not_to be_empty
    end
  end

  describe "'list_name' column" do
    it 'If not exist, a validation error occurs' do
      by_list_tweet = ByListTweet.new(
        user_id: 12345,
        id_number: 54321,
        full_text: 'Hello, World!',
        serialized_object: {},
        list_id_number: 55555,
        list_serialized_object: {}
      )

      by_list_tweet.valid?
      expect(by_list_tweet.errors.messages).not_to be_empty
    end
  end

  describe "'list_serialized_object' column" do
    it 'If not exist, a validation error occurs' do
      by_list_tweet = ByListTweet.new(
        user_id: 12345,
        id_number: 54321,
        full_text: 'Hello, World!',
        serialized_object: {},
        list_id_number: 55555,
        list_name: 'Awesome List'
      )

      by_list_tweet.valid?
      expect(by_list_tweet.errors.messages).not_to be_empty
    end
  end

  describe "'list_id_number', 'list_name' and 'list_serialized_object' column" do
    it 'If exist, a validation is true' do
      by_list_tweet = ByListTweet.new(
        user_id: 12345,
        id_number: 54321,
        full_text: 'Hello, World!',
        serialized_object: {},
        list_id_number: 55555,
        list_name: 'Awesome List',
        list_serialized_object: {
          foo: 'bar'
        }
      )

      by_list_tweet.valid?
      expect(by_list_tweet.errors.messages).to be_empty
    end
  end
end
