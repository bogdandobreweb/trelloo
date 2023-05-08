class BaseDestroyer < CommonBase
  attr_reader :record

  def call(attrs)
    @record = model.find(attrs)
    if @record.present?
      record = @record.destroy
      success = record.present? && record.errors.blank?
      add_error(message: "Failed to destroy #{self.class.name}!", traceback: record.errors) unless success
    else
      add_error(message: "#{model.name} not found!")
    end
  end
end
