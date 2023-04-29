class StoriesController < ApplicationController
    before_action :authenticate_user!

    def index
        render json: Stories::StoriesPresenter.new(params[:board_id]).as_json, status: :ok
    end

    def show
        story = set_story
        authorize story
        render json: Stories::StoryPresenter.new(story.id).as_json, status: :ok
    end

    def create
        @story = Story.find(params[:id])
        authorize @story
        story_creator = Stories::StoryCreator.new.call(story_params)
        story = story_creator.record
        if story.errors.empty?
            render json: Stories::StoryPresenter.new(story.id).as_json, status: :created
        else
            render json: { errors: story.errors }, status: :unprocessable_entity
        end
    end

    def update
        @story = Story.find(params[:id])
        authorize @story
        story = Stories::StoryUpdater.new.call(story_params)
        if story.errors.empty?
          render json: Stories::StoryPresenter.new(story.id).as_json, status: :ok
        else
          render json: story.errors, status: :unprocessable_entity
        end
      end

    def destroy
        story_destroyer = Stories::StoryDestroyer.new.call(set_story.id)
        authorize story
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
        params.require(:story).permit(policy(@story).permitted_attributes)
    end

end
