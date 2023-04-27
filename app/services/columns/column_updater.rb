class Columns::ColumnUpdater
    include CommonHelper
  
    def initialize(column_id, params)
      @column = Column.find(column_id)
      @params = params
    end
  
    def call
      @errors = []
      @column.update(@params)
  
      if @column.valid?
        add_success("Column updated successfully!")
        @column
      else
        add_error("Failed to update column! Errors: #{column.errors.full_messages}")
        { errors: @errors }
      end
    end
  end
  