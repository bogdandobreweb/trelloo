class Stories::StoriesPresenter
include CommonHelper

  def initialize(board_id, story_presenter: Stories::StoryPresenter)
    @board_id = board_id
    @story_presenter = story_presenter
    @errors = []
  end

  def as_json(*)
    stories_data = stories_skope.map do |story|
            @story_presenter.new(story.id).as_json
            end
   
    rescue StandardError => e
    add_error(message: "Failed to present story data!", traceback: "#{e.message}")
  end

    def stories_skope
    Story.where(board_id: @board_id).includes(:column)
    end
end