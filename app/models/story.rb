class Story < ApplicationRecord
  belongs_to :column
  belongs_to :user
  belongs_to :board
  has_many :comments, dependent: :destroy

  def api_attributes
    {
      id: id,
      name: name,
      description: description,
      column: column.name
    }
  end

  def valid_column_id_change?(column_id)
    if self.column_id.present?
      old_column_id = self.column_id
      new_column_id = column_id.to_i
      
      unless (new_column_id - old_column_id).abs == 1
        return false
      end
      true
    end
  end
end
