class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_board, only: [:index, :create]
  before_action :authorize_board_and_owner, only: [:update, :destroy]

  def index
    boards_collector = Boards::BoardsCollector.new(base_filter_service: Boards::BoardsFilter.new)
    boards = boards_collector.call
    render json: {boards: Boards::BoardsPresenter.new(boards).as_json}, status: :ok
  end

  def show
    render json: {board: Boards::BoardPresenter.new(@board.id).as_json}, status: :ok
  end

  def create
    board = Boards::BoardCreator.new(board_params_for_create).call
    if board.errors.empty?
      render json: {board: Boards::BoardPresenter.new(board).as_json}, status: :created
    else
      render json: { errors: board.errors }, status: :unprocessable_entity
    end
  end

  def update
    board = Boards::BoardUpdater.new(@board.id, board_params).call
    if board.errors.empty?
      render json: { boards: Boards::BoardPresenter.new(board).as_json }, status: :ok
    else
      render json: { errors: board.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    board_destroyer = Boards::BoardDestroyer.new(params[:id])
    result = board_destroyer.call
    if result.errors.empty?
      head :no_content
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(policy(@board).permitted_attributes)
  end

  def board_params_for_create
    params.require(:board).permit(policy(Board).permitted_attributes_for_create)
  end

  def authorize_board
    authorize Board
  end

  def authorize_board_and_owner
  end
end