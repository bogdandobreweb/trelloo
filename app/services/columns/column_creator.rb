class Columns::ColumnCreator
    include CommonHelper
  
    def initialize(params)
      @params = params
    end
  
    def call
      @errors = []
      column = Column.create(@params)
  
      if column.valid?
        add_success("Column created successfully!")
        column
      else
        add_error("Failed to create column! Errors: #{column.errors.full_messages}")
        { errors: @errors }
      end
    end
  end
  