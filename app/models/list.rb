class List < ApplicationRecord
  has_many :tweets

  delegate :description, to: :deserialize
  delegate :full_name, to: :deserialize
  delegate :member_count, to: :deserialize
  delegate :mode, to: :deserialize
  delegate :name, to: :deserialize
  delegate :slug, to: :deserialize
  delegate :subscriber_count, to: :deserialize
  delegate :attrs, to: :deserialize
  delegate :members_uri, to: :deserialize
  delegate :subscribers_uri, to: :deserialize
  delegate :uri, to: :deserialize
  delegate :uri?, to: :deserialize
  delegate :created?, to: :deserialize

  # TODO: Refactoring
  # Pick up the latest id_number record
  scope :remove_duplicated, lambda {
    list_id_numbers = pluck(:id_number)
    duplicated_list_id_numbers = list_id_numbers.select{|id_number| list_id_numbers.count(id_number) > 1}.uniq
    removed_list_index_ids = []

    duplicated_list_id_numbers.each do |id_number|
      target_list_records = where(id_number: id_number)
      target_list_latest_record = where(id_number: id_number).order(created_at: :desc).first

      target_list_records.each do |record|
        # Old records will be removed
        removed_list_index_ids << record.id if record.created_at < target_list_latest_record.created_at
      end
    end

    where.not(id: removed_list_index_ids)
  }

  def self.latest
    order(id_number: :desc).first
  end

  def deserialize
    Twitter::List.new(JSON.parse(serialized_object, symbolize_names: true))
  end
end
