class ErrorDecorator
  def initialize(obj)
    @obj = obj
  end

  def call(attrs)
    @obj.instance_variable_set(:@errors, [])
    @obj.call(attrs)
  end
end
