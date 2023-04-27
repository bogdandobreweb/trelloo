class CommentsController < ApplicationController
    before_action :authenticate_user!

    def index
        story = Story.find(params[:story_id])
        render json: Stories::StoryPresenter.new(story).as_json
    end

    def show
        render json: Comments::CommentPresenter.new(params[:id]).as_json
    end

    def create
        comment = Comments::CommentCreator.new(current_user, comment_params).call
    
        render json: Stories::StoryPresenter.new(comment[:story]).as_json
    end
    
    private

    def comment_params
    params.require(:comment).permit(:body, :story_id)
    end
end
