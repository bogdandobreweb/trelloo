class Columns::ColumnPresenter
  include CommonHelper

  def initialize(column_id)
    @column = Column.find(column_id)
    @errors = []
  end

  def as_json
    column_data = {
      id: @column.id,
      name: @column.name,
      order_id: @column.order_id
    }

    add_success('Column data is ready!')
    { column: column_data, errors: @errors }
  rescue StandardError => e
    add_error("Failed to present column data! Error: #{e.message}")
    { errors: @errors }
  end
end
