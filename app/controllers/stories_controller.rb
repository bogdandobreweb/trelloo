class StoriesController < ApplicationController
  before_action :authenticate_user!
  # before_action :check_valid_column_id_change, only: [:update]

  def index
    @board = Board.find(params[:board_id])
    stories = Stories::StoryCollector.new(base_filter_service: Stories::StoriesFilter.new).call
    authorize stories
    render json: Stories::StoriesPresenter.new(@board.id).as_json, status: :ok
  end

  def show
    story = set_story
    authorize story
    render json: Stories::StoryPresenter.new(story.id, params[:board_id]).as_json, status: :ok
  end

  def create
    puts story_params_for_create
    @story_creator = Stories::StoryCreator.new.call(story_params_for_create.merge(user_id: current_user.id).merge(board_id: params[:board_id]))
    authorize @story_creator
    if @story_creator.errors.empty?
      render json: Stories::StoryPresenter.new(@story_creator.id, @story_creator.board_id).as_json,
             status: :created
    else
      render json: { errors: story.errors }, status: :unprocessable_entity
    end
  end

  def update
    @story = Story.find(params[:id])
    authorize @story
    if @story.update(story_params)
      updated_story = Stories::StoryUpdater.new.call(story_params)
      deployed_story = Stories::StoryUpdater.new.check_update_story(updated_story)
      render json: deployed_story, status: :ok
    else
      render json: { errors: @story.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    story_destroyer = Stories::StoryDestroyer.new
    story = story_destroyer.call(set_story.id)
    if story.nil?
      render json: 'Story deleted', status: :ok
    elsif story.errors.exists?
      render json: { errors: story.errors }, status: :bad_request
    else
      head :no_content
    end
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(policy(@story).permitted_attributes)
  end

  def story_params_for_create
    params.require(:story).permit(policy(Story).permitted_attributes_for_create)
  end

  def check_valid_column_id_change
    @story = Story.find(params[:id])
    return if @story.valid_column_id_change?(params[:story][:column_id])

    render json: { error: 'Invalid column ID change' }, status: :unprocessable_entity
  end
end
