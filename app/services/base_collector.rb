# frozen_string_literal: true

class BaseCollector < CommonBase
  attr_reader :records

  def initialize(base_filter_service: BaseFilter.new)
    @base_filter_service = base_filter_service
  end

  def call(options: {})
    @records = @base_filter_service.call(options:)
    success = @records.present?

    return @records if success

    add_error(message: 'Failed to collect !')
  end
end
