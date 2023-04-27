class Comments::CommentCreator
    def initialize(user, comment_params)
        @user = user
        @comment_params = comment_params.merge(user_id: @user.id)
        end
        
    def call
    comment = Comment.create(@comment_params)
    
    #returneaza status sau obiectul - > comment
    # add method to verify if successful true / false
    # array cu erori pentru fiecare serviciu de Board/Story/..
    unless comment.save
    return { success: false, errors: comment.errors }
    end

    { success: true, comment: comment, story: comment.story }
    end
    
end