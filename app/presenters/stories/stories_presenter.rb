class Stories::StoriesPresenter
include CommonHelper

  def initialize(board_id)
    @board = Board.find(board_id)
    @errors = []
  end

  def as_json(*)
    stories_data = @board.stories.where(board_id: @board.id).includes(:column).map do |story|
            Stories::StoryPresenter.new(story.id).as_json
            end
    add_success("Story data is ready!")
    { story: stories_data, errors: @errors}
    rescue StandardError => e
    add_error("Failed to present story data! Error: #{e.message}")
    { errors: @errors }
  end
end