class BaseCreator
  include CommonHelper
  include PrerequisitesHelper

  attr_reader :record

  def self.call
    obj = self.class.new
    obj.needed_before_call
    obj.call
    obj.needed_after_call
  end
  
  def call(attrs)
    @record = model.new(attrs)
    success = @record.save
    return @record if success?
    
    add_error(message: "Failed to create in #{self.class.name}!", traceback: @record.errors)
  end

  def model
    raise "Must be implemented in inheriting class"
  end

  def needed_before_call
    prerequisites
  end
  
  def needed_after_call
  end
end
