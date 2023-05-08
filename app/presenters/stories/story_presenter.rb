# frozen_string_literal: true

module Stories
  class StoryPresenter
    include CommonHelper

    def initialize(story_id, board_id, comment_presenter: Comments::CommentPresenter)
      @story = Board.find(board_id).stories.find(story_id)
      @comment_presenter = comment_presenter
      @errors = []
    end

    def as_json
      story_data = @story.api_attributes
      story_data[:comments] = @story.comments.map { |comment| @comment_presenter.new(comment.id).as_json }

      story_data
    rescue StandardError => e
      add_error(message: 'Failed to present story data!', traceback: e.message.to_s)
    end
  end
end
