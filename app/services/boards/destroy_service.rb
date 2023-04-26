class Boards::DestroyService
  def initialize(board)
    @board = board
  end

  def call
    @board.destroy
  end
end