class Story < ApplicationRecord
  belongs_to :column
  belongs_to :user
  belongs_to :board
  has_many :comments
end
