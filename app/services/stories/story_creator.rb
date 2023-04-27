class Stories::StoryCreator
  def initialize(story_params)
    @story_params = story_params
  end

  def call
    user = User.find(@story_params[:user_id])
    board = user.boards.find(@story_params[:board_id])
    story = board.stories.build(@story_params)
    story.user = user

    unless story.save
      return { success: false, errors: story.errors}
    end
  
    { success: true, story: story }
  end
end