class Comments::CommentPresenter
include CommonHelper

    def initialize(comment_id)
      @comment = Comment.find(comment_id)
      @errors = []
    end
  
    def as_json
      comment_data = @comment.api_attributes
    
      comment_data

      rescue StandardError => e
        add_error(message: "Failed to present comment data!", traceback: "#{e.message}")
        { errors: @errors }
      end
  end