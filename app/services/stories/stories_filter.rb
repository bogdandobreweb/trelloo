class Stories::StoriesFilter < BaseFilter
  def call(options: {})
    return model.all if options.blank?

    result = model
    result = result.where(column_id: options[:column_id]) if options.key?(:column_id)
    result = result.where(board_id: options[:board_id]) if options.key?(:board_id)
    result = result.where(user_id: options[:user_id]) if options.key?(:user_id)

    result
  end
end
