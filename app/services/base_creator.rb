class BaseCreator < CommonBase
  attr_reader :record

  def call(attrs)
    if attrs.blank?
      add_error(message: 'Create attributes missing!')
      return
    end

    @record = model.new(attrs)
    if @record.blank?
      add_error(message: "#{model.name} not found!")
      return
    end

    success = @record.save
    return @record if success

    add_error(message: "Failed to create in #{self.class.name}!", traceback: @record.errors)
  end
end
