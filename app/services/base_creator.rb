class BaseCreator < CommonBase

  attr_reader :record
  
  def call(attrs)
    @record = model.new(attrs)
    success = @record.save
    return @record if success?
    
    add_error(message: "Failed to create in #{self.class.name}!", traceback: @record.errors)
  end
end
