class Boards::Presenter
    def initialize(boards)
      @boards = boards
    end
  
    def as_json(*)
        @boards.map do |board| #apelam BoardPresenter
          {
            id: board.id,
            name: board.name,
            created_at: board.created_at,
            updated_at: board.updated_at
          }
        end
      end
  end