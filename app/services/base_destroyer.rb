class BaseDestroyer
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
    @record = model.find(attrs)
    record = @record.destroy
    success = record.present? && record.errors.blank?
    unless success
      add_error(message: "Failed to destroy #{self.class.name}!", traceback: @record.errors)
    end
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
