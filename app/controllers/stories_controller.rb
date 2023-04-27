class StoriesController < ApplicationController
    before_action :authenticate_user!

    def index
        board = Board.find(params[:board_id])
        render json: Stories::StoriesPresenter.new(board.id).as_json, status: ()
    end

    def show
        story = set_story
        render json: Stories::StoryPresenter.new(story.id).as_json
    end

    def create
        story = Stories::StoryCreator.new(story_params).call
        render json: Stories::StoryCreator.new(story_params).as_json, status: (story[:success] ? :created : :unprocessable_entity)
      end
    

    private
  
    def set_story
      @story = Story.find(params[:id])
    end
  
    def story_params
      params.require(:story).permit(:name, :description, :column_id, :user_id, :board_id)
    end

end
