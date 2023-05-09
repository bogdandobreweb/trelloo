# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users_roles
  has_many :users, through: :users_roles
  has_many :access_controls
  has_many :actions, through: :access_controls
end
