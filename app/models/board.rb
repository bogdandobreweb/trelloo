# frozen_string_literal: true

class Board < ApplicationRecord
  validates :name, presence: true

  has_many :board_subscriptions
  has_many :users, through: :board_subscriptions
  has_many :stories
end
