class Columns::ColumnCreator
    def initialize(params)
        @params = params
      end
    
      def call
        Column.create(@params)
      end
end