class BoardsController < ApplicationController
    before_action :set_board, only: [:show, :update, :destroy]
    before_action :authenticate_user!

    def index
        puts current_user.email
        boards = Boards::Collector.new(current_user).call
        render json: Boards::Presenter.new(boards).as_json
    end
  
    def show
      render json: @board
    end
  
    def create
      board = Boards::CreateService.new(board_params).call
      if board.valid?
        render json: Boards::BoardsPresenter.new(board).as_json, status: :created
      else
        render json: board.errors, status: :unprocessable_entity
      end
    end
  
    def update
      Boards::UpdateService.new(@board, board_params).call
      if @board.valid?
        render json: @board
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      Boards::DestroyService.new(@board).call
      head :no_content
    end
  
    private
  
    def set_board
      @board = Board.find(params[:id])
    end
  
    def board_params
      params.require(:board).permit(:name)
    end
  end