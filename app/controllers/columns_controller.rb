class ColumnsController < ApplicationController
  before_action :set_column, only: %i[show update destroy]
  before_action :authenticate_user!

  def index
    columns_collector = Columns::ColumnsCollector.new(base_filter_service: Columns::ColumnsFilter.new)
    columns = columns_collector.call
    authorize columns
    render json: Columns::ColumnsPresenter.new.as_json, status: :ok
  end

  def show
    authorize @column
    render json: Columns::ColumnPresenter.new(set_column.id).as_json, status: :ok
  end

  def create
    column_creator = Columns::ColumnCreator.new(column_params).call
    authorize column_creator
    if column_creator.errors.empty?
      render json: Columns::ColumnPresenter.new(column_creator.id).as_json, status: :created
    else
      render json: { errors: column_creator.errors }, status: :bad_request
    end
  end

  def update
    column_updater = Columns::ColumnUpdater.new(@column.id, column_params).call
    authorize column_updater
    if column_updater.errors.empty?
      head :no_content
    else
      render json: { errors: column_updater.errors }, status: :bad_request
    end
  end

  def destroy
    column_destroyer = Columns::ColumnDestroyer.new(@column.id).call
    authorize column_destroyer
    if column_destroyer.errors.empty?
      head :no_content
    else
      render json: { errors: column_destroyer.errors }, status: :bad_request
    end
  end

  private

  def set_column
    @column = Column.find(params[:id])
  end

  def column_params
    params.require(:column).permit(policy(@column).permitted_attributes)
  end
end
