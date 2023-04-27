class Boards::BoardDestroyer
  include CommonHelper
  
  def initialize(board_id)
    @board = Board.find(board_id)
  end
  
  def call
    @errors = []

    @board.destroy

  rescue StandardError => e
    add_error("Failed to destroy the board! Error: #{e.message}")
    { errors: @errors }
  end
end
