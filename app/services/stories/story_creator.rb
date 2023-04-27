class Stories::StoryCreator
  include CommonHelper

  def initialize(story_params)
    @story_params = story_params
  end

  def call
    @errors = []
    user = User.find(@story_params[:user_id])
    board = user.boards.find(@story_params[:board_id])
    story = board.stories.build(@story_params)
    story.user = user

    if @story.valid?
      add_success("Column created successfully!")
      @story
    else
      add_error("Failed to create column! Errors: #{story.errors.full_messages}")
      { errors: @errors }
    end
  end
end