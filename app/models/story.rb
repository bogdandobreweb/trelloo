# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :column
  belongs_to :user
  belongs_to :board
  has_many :comments, dependent: :destroy

  DEPLOYED_COLUMN = 4

  def api_attributes
    {
      id:,
      name:,
      description:,
      column: column.name,
      side_status:,
      user_id:,
      delivered_at:
    }
  end

  def valid_column_id_change?(column_id)
    return unless self.column_id.present?

    old_column_id = self.column_id
    new_column_id = column_id.to_i

    return false unless (new_column_id - old_column_id).abs == 1

    true
  end
end
