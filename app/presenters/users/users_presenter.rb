class Users::UsersPresenter
    def initialize(user)
      @user = user
    end
  # 
    def as_json(*)
      boards_data = @user.boards.includes(:stories).map do |board|
        {
          id: board.id,
          name: board.name,
          stories: board.stories.includes(:column).map do |story|
            {
              id: story.id,
              name: story.name,
              description: story.description,
              column: story.column.name
            }
          end
        }
      end
  
      { boards: boards_data }
    end
  end