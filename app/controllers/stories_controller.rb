class StoriesController < ApplicationController
    before_action :authenticate_user!

    def index
        board = Board.find(params[:board_id])
        render json: Stories::StoriesPresenter.new(board.id).as_json, status: :ok
    end

    def show
        story = set_story
        render json: Stories::StoryPresenter.new(story.id).as_json, status: :ok
    end

    def create
        story_creator = Stories::StoryCreator.new(story_params)
        story = story_creator.call
    
        if story.errors.empty?
            render json: Stories::StoryPresenter.new(story).as_json, status: :created
        else
            render json: { errors: story.errors }, status: :unprocessable_entity
        end
    end

    def update
        story = Stories::StoryUpdater.new(@story.id, story_params).call

        if story.errors.empty?
            render json: Stories::StoryPresenter.new(story).as_json, status: :updated
        else
            render json: @story.errors, status: :unprocessable_entity
        end
    end
    

    def destroy
        story_destroyer = Stories::StoryDestroyer.new(set_story.id).call
  
      if story_destroyer.errors.empty?
        head :no_content
      else
        render json: { errors: story_destroyer.errors }, status: :bad_request
      end
    end

    private
  
    def set_story
      @story = Story.find(params[:id])
    end
  
    def story_params
      params.require(:story).permit(:name, :description, :column_id, :user_id, :board_id)
    end

end
