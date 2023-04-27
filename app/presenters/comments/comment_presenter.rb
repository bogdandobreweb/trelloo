class Comments::CommentPresenter
include CommonHelper

    def initialize(comment_id)
      @comment = Comment.find(comment_id)
      @errors = []
    end
  
    def as_json
        comment_data = {
          id: @comment.id,
          body: @comment.body,
          user_id: @comment.user_id,
          story_id: @comment.story_id
        }
    
        add_success("Comment data is ready!")
        { comment: comment_data, errors: @errors}
      rescue StandardError => e
        add_error("Failed to present comment data! Error: #{e.message}")
        { errors: @errors }
      end
  end