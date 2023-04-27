class CommentsController < ApplicationController
    before_action :authenticate_user!

    def index
        story = Story.find_by(id: params[:story_id])
        if story.present?
            render json: Comments::CommentsPresenter.new(story.id).as_json, status: :ok
          else
            render json: { errors: ["Story not found"] }, status: :not_found
          end
    end

    def show
        render json: Comments::CommentPresenter.new(params[:id]).as_json, status: :ok
    end

    def create
        comment = Comments::CommentCreator.new(current_user, comment_params).call, status: :created
    
        render json: Stories::StoryPresenter.new(comment.story_id).as_json, status: :unprocessable_entity
    end
    
    def update
        comment_updater = Comments::CommentUpdater.new(set_comment.id, comment_params).call
    
        if comment_updater.errors.empty?
        render json: Comments::CommentPresenter.new(params[:id]).as_json, status: :updated
        else
        render json: { errors: comment_updater.errors }, status: :bad_request
        end
    end

    def destroy
        comment_destroyer = Comments::CommentDestroyer.new(set_comment.id).call
  
        if comment_destroyer.errors.empty?
          head :no_content
        else
          render json: { errors: comment_destroyer.errors }, status: :bad_request
        end
    end
    
    private
    def set_comment
    @comment = Comment.find(params[:id])
    end

    def comment_params
    params.require(:comment).permit(:body, :story_id)
    end
end
