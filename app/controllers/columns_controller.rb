class ColumnsController < ApplicationController
    before_action :authenticate_user!

    def create
        column = Columns::ColumnCreator.new(column_params).call
        render json: Columns::ColumnCreator.new(column_params).as_json, status: (column[:success] ? :created : :unprocessable_entity)
    end

    private
  
    def set_column
      @column = Column.find(params[:id])
    end
  
    def column_params
      params.require(:column).permit(:name, :order_id)
    end
end
