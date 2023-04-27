class Comments::CommentUpdater
    include CommonHelper
  
    def initialize(comment_id, params)
      @comment = Comment.find(comment_id)
      @params = params
    end
    
    def call
      @errors = []
      @comment.update(@params)
  
      if @comment.valid?
        add_success("Board updated successfully!")
        @comment
      else
        add_error("Failed to update board! Errors: #{board.errors}")
        { board: @board, errors: @errors }
      end
  
    rescue StandardError => e
      add_error("Failed to update board! Error: #{e.message}")
      { errors: @errors }
    end
  end
  