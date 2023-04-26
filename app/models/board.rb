class Board < ApplicationRecord
  has_many :users, through: :board_memberships
  has_many :columns
end
