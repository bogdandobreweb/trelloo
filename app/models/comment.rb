class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :story

  def api_attributes
    {
      id: id,
      body: body,
      user_id: user_id,
      story_id: story_id
    }
  end
end
