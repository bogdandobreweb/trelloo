class BoardsController < ApplicationController
    before_action :set_board, only: [:show, :update, :destroy]
    before_action :authenticate_user!

    def index
        boards_collector = Boards::BoardsCollector.new
        boards = boards_collector.call
      
        # if boards.errors.empty?
          render json: Boards::BoardsPresenter.new(boards).as_json, status: :ok
        # else
        #   render json: { errors: boards_collector.errors }, status: :bad_request
        # end
    end
  
    def show
        render json: Boards::BoardPresenter.new(@board.id).as_json
    end

    def create
        board = Boards::BoardCreator.new(board_params).call
      
        if board.errors.empty?
          render json: Boards::BoardPresenter.new(board).as_json, status: :created
        else
          render json: { errors: board.errors }, status: :unprocessable_entity
        end
    end
  
    def update
        board = Boards::BoardUpdater.new(@board.id, board_params).call

        if board.errors.empty?
        render json: Boards::BoardPresenter.new(board).as_json, status: :updated
      else
        render json: @board.errors, status: :unprocessable_entity
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

  end