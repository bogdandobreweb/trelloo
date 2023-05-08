# frozen_string_literal: true

module Boards
  class BoardsPresenter
    include CommonHelper

    def initialize(boards)
      raise 'Board not present' unless boards.present?

      @boards = boards
    end

    def as_json(*)
      @boards.map { |board| Boards::BoardPresenter.new(board.id).as_json }
    end
  end
end
