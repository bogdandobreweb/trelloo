class Comments::CommentDestroyer
    include CommonHelper
    attr_reader :errors

    def initialize(comment_id)
      @comment = Comment.find(comment_id)
    end
  
    def call
      @errors = []
      @comment.destroy
      
    rescue StandardError => e
      add_error("Failed to destroy the column! Error: #{e.message}")
      { errors: @errors }
    end
  end
  