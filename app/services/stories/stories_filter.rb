class Stories::StoriesFilter < BaseFilter

def call(options: {})
  return model.all if options.blank?
  
  result = model 
  result = result.where(board_id: options.board_id) if options.board_id.present?
  result = result.where(column_id: options.column_id) if options.column_id.present?
  result = result.where(user_id: options.user_id) if options.user_id.present?

  result
end



end