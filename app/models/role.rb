class Role < ApplicationRecord
  belongs_to :user
  has_many :access_controls
  has_many :actions, through: :access_controls
end
