# frozen_string_literal: true

module Users
  class UserPresenter
    def initialize(user)
      @user = user
    end

    def as_json(*)
      boards_data = @user.boards.includes(:stories).map do |board|
        {
          id: board.id,
          name: board.name,
          stories: board.stories.where(user_id: @user.id).includes(:column).map do |story|
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
end
