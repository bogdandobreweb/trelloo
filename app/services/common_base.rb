class CommonBase
  include CommonHelper
  include ErrorsHelper

  def self.call(*args)
    obj = new(*args)
    obj.needed_before_call
    obj.call
    obj.needed_after_call
  end

  def model
    klass = if is_a?(Class)
              self
            else
              self.class
            end
    klass.name.demodulize.underscore.split('_').first.singularize.capitalize.constantize
  end

  def call
    raise 'Must be implemented in inheriting class'
  end

  def needed_before_call
    init_errors
  end

  def needed_after_call; end
end
