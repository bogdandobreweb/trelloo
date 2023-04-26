class Boards::Collector
    def initialize(current_user)
      @current_user = current_user
    end
  
    def call(column_id: nil)
        boards = @current_user.boards
        boards = boards.where(column_id: column_id) if column_id.present?
        boards
    end
  end