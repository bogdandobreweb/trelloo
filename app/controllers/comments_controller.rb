class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: [:show, :update, :destroy]
    before_action :set_story, only: [:index, :create]
    before_action :authorize_creator, only: [:create]
    before_action :authorize_comment, only: [:show, :update, :destroy]
  
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
      comment_creator = Comments::CommentCreator.new
      comment = comment_creator.call(comment_params_for_create.merge(user_id: current_user.id, story_id: params[:story_id]))
      if comment.errors.empty?
        render json: Stories::StoryPresenter.new(params[:story_id], set_story.board_id).as_json, status: :ok
      else
        render json: { errors: comment.errors }, status: :bad_request
      end
    end
  
    def update
      comment_updater = Comments::CommentUpdater.new.call(comment_params)
      if comment_updater.errors.empty?
        render json: Comments::CommentPresenter.new(params[:id]).as_json, status: :ok
      else
        render json: { errors: comment_updater.errors }, status: :bad_request
      end
    end
  
    def destroy
      comment_destroyer = Comments::CommentDestroyer.new
      comment = comment_destroyer.call(set_comment.id)
      if comment.nil?
        render json: "Comment deleted" , status: :ok
      elsif comment.errors.exists?
        render json: { errors: comment.errors }, status: :bad_request
      else
        head :no_content
      end
    end
  
    private
  
    def set_comment
        @comment = Comment.find(params[:id])
    end
  
    def set_story
        @story = Story.find(params[:story_id])
    end
  
    def comment_params
        params.require(:comment).permit(policy(@comment).permitted_attributes)
    end
  
    def comment_params_for_create
        params.require(:comment).permit(policy(Comment).permitted_attributes_for_create)
    end
  
    def authorize_creator
    end
  
    def authorize_comment
      authorize @comment
    end
  end