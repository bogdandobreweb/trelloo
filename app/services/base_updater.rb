class BaseUpdater < CommonBase

  attr_reader :record

  def call(attrs)
    @record = model.find(attrs[:id])
    if @record.present?
      success = @record.update(attrs)
      return @record if success
      
      add_error(message: "Failed to update in #{self.class.name}!", traceback: @record.errors)
    else
      add_error(message: "#{model.name} not found!", traceback: [])  
    end
  end

end