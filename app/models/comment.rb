# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :story

  def api_attributes
    {
      id:,
      body:,
      user_id:,
      story_id:
    }
  end
end
