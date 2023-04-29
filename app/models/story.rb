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
end
