class Boards::BoardsFilter < BaseFilter

  def call(options: {})
    return model.all if options.blank?
    
    result = model 
    result = result.where(name: options.name) if options.name.present?
    result
  end
  
  def subscriptions_for_user(user_id)
    BoardSubscription.where(user_id: user.id)
  end
end