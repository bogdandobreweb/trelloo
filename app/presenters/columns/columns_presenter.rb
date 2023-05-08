# frozen_string_literal: true

module Columns
  class ColumnsPresenter
    include CommonHelper

    def initialize
      @columns = Column.all
      @errors = []
    end

    def as_json(*)
      @columns.map { |column| Columns::ColumnPresenter.new(column.id).as_json }
    end
  end
end
