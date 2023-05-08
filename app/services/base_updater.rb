# frozen_string_literal: true

class BaseUpdater < CommonBase
  attr_reader :record

  def call(attrs)
    if attrs.blank?
      add_error(message: 'Update attributes missing!')
      return
    end

    @record = model.find_by(id: attrs[:id])
    if @record.blank?
      add_error(message: "#{model.name} not found!")
      return nil
    end

    success = @record.update(attrs)
    return @record if success

    add_error(message: "Failed to update in #{self.class.name}!", traceback: @record.errors)

    nil
  end
end
