class Stories::StoryPresenter
include CommonHelper

  def initialize(story_id)
    @story = Story.find(story_id)
    @errors = []
  end

  def as_json
    story_data = {
      id: @story.id,
      name: @story.name,
      description: @story.description,
      column: @story.column.name,
      comments: @story.comments.map { |comment| Comments::CommentPresenter.new(comment.id).as_json }
    }
    add_success("Story data is ready!")
    { story: story_data, errors: @errors}
  rescue StandardError => e
    add_error("Failed to present story data! Error: #{e.message}")
    { errors: @errors }
  end
end