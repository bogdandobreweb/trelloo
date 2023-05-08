# frozen_string_literal: true

module Comments
  class CommentPresenter
    include CommonHelper

    def initialize(comment_id)
      @comment = Comment.find(comment_id)
      @errors = []
    end

    def as_json
      @comment.api_attributes
    rescue StandardError => e
      add_error(message: 'Failed to present comment data!', traceback: e.message.to_s)
      { errors: @errors }
    end
  end
end
