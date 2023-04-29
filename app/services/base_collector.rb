class BaseCollector
  include CommonHelper
  include PrerequisitesHelper

  attr_reader :records

  def self.call(*args)
    obj = new(*args)
    obj.needed_before_call
    obj.call
    obj.needed_after_call
  end

  def call
    @records = model.all
    success = @records
    
    return @records if success
    
    add_error(message: "Failed to update in #{self.class.name}!", traceback: @records.errors)
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