# frozen_string_literal: true

class BoardSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :board
end
