class Boards::BoardCreator
  include CommonHelper
  
  def initialize(params)
    @params = params
  end
  
  def call
    @errors = []
    board = Board.create(@params)
    if board.valid?
      add_success("Board created successfully!")
      board
    else
      add_error("Failed to create board! Errors: #{board.errors}")
      {board: board, errors: @errors }
    end
  end
end