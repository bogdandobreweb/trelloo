class Boards::BoardUpdater
  include CommonHelper

  def initialize(board_id, params)
    @board = Board.find(board_id)
    @params = params
  end
  
  def call
    @errors = []
    @board.update(@params)

    if @board.valid?
      add_success("Board updated successfully!")
      @board
    else
      add_error("Failed to update board! Errors: #{board.errors}")
      { board: @board, errors: @errors }
    end

  rescue StandardError => e
    add_error("Failed to update board! Error: #{e.message}")
    { errors: @errors }
  end
end
