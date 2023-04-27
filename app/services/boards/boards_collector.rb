class Boards::BoardsCollector
  include CommonHelper
  attr_reader :errors

  def initialize(current_user)
    @current_user = current_user
  end
  
  def call
    @errors = []
    boards = @current_user.boards
    add_success("Boards fetched successfully!")
    boards
  rescue StandardError => e
    add_error("Failed to fetch boards! Error: #{e.message}")
  end
end