class Board < ApplicationRecord
  has_many :board_subscriptions
  has_many :users, through: :board_subscriptions
  has_many :stories
end
