class BaseUpdater
  include CommonHelper
  include PrerequisitesHelper

  attr_reader :record

  def self.call(*args)
    obj = new(*args)
    obj.needed_before_call
    obj.call
    obj.needed_after_call
  end

  def call(attrs)
    puts attrs
    @record = model.find(attrs[:id])
    success = @record.update(attrs)
    return @record if success
    
    add_error(message: "Failed to update in #{self.class.name}!", traceback: @record.errors)
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