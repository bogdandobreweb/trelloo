# frozen_string_literal: true

class Action < ApplicationRecord
  has_many :access_controls
  has_many :roles, through: :access_controls
end
