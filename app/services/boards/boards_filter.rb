class Boards::BoardsFilter < BaseFilter

  def call(options: {})
    model.all if options.blank?
    
    # result = model 
    # result = result.where(user_id: options.user_id) if options.user_id.present?
  
    # result
  end
  
  
  
  end