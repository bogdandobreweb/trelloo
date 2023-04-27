class Comments::CommentCreator
    include CommonHelper

    def initialize(user, comment_params)
        @user = user
        @comment_params = comment_params.merge(user_id: @user.id)
    end
        
    def call
    @errors = []
    comment = Comment.create(@comment_params)
    
    if comment.valid?
        add_success("Column created successfully!")
        comment
      else
        add_error("Failed to create column! Errors: #{comment.errors.full_messages}")
        { errors: @errors }
      end
    end
    
end