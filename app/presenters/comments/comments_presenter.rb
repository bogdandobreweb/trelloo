# frozen_string_literal: true

module Comments
  class CommentsPresenter
    include CommonHelper

    def initialize(story_id, comment_presenter: Comments::CommentPresenter)
      @story = Story.find(story_id)
      @comment_presenter = comment_presenter
      @errors = []
    end

    def as_json
      @story.comments.map { |comment| @comment_presenter.new(comment.id).as_json }
    end
  end
end
