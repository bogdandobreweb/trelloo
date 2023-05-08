# frozen_string_literal: true

class Column < ApplicationRecord
  has_many :stories
end
