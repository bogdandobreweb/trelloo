class Boards::UpdateService
  def initialize(board, params)
    @board = board
    @params = params
  end

  def call
    @board.update(@params)
    @board
  end
end