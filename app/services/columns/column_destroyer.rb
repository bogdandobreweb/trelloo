class Columns::ColumnDestroyer
    include CommonHelper
  
    def initialize(column_id)
      @column = Column.find(column_id)
    end
  
    def call
      @errors = []
      @column.destroy
      
    rescue StandardError => e
      add_error("Failed to destroy the column! Error: #{e.message}")
      { errors: @errors }
    end
  end
  