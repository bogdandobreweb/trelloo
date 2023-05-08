# frozen_string_literal: true

module CommonHelper
  attr_reader :success

  def add_error(message:, traceback: [])
    @errors ||= []
    @errors << { message:, traceback: traceback.as_json }
  end

  def success=(resolve)
    @success &&= resolve
  end

  def add_success(success)
    @success ||= []
    @success << success
  end

  def success?
    @success
  end
end
