class Boards::BoardPresenter
  include CommonHelper

  def initialize(board_id)
    raise 'Board not present' unless board_id.present?

    @board = Board.find(board_id)
  end

  def as_json
    @errors = []
    board_data = {
      id: @board.id,
      name: @board.name,
      created_at: @board.created_at,
      updated_at: @board.updated_at
    }
    add_success('Boards fetched successfully!')
    board_data
  rescue StandardError => e
    add_error("Failed to fetch boards! Error: #{e.message}")
  end
end
