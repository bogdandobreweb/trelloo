class CommonBase
  include CommonHelper
  include PrerequisitesHelper
  

  def self.call(*args)
    obj = new(*args)
    obj.needed_before_call
    obj.call
    obj.needed_after_call
  end

  def model
    classname.demodulize.underscore.split('_').first
 end
  
  def call
    raise "Must be implemented in inheriting class"
  end

  def needed_before_call
    prerequisites
  end

  def needed_after_call
  end
end