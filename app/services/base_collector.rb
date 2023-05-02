class BaseCollector < CommonBase

  attr_reader :records

  def call
    @records = model.all
    success = @records.present? 
    
    return @records if success
    
    add_error(message: "Failed to update in #{self.class.name}!", traceback: @records.errors)
  end

end