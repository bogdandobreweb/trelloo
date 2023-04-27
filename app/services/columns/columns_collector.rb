class Columns::ColumnsCollector
    include CommonHelper
    attr_reader :errors
    
    def initialize
    end
    
    def call
    @errors = []
    columns = Column.all
    
    add_success("Columns collected successfully!")
    columns

    rescue StandardError => e
        add_error("Failed to collect columns! Error: #{e.message}")
        { errors: @errors }
    end
  end