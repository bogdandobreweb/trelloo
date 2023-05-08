# frozen_string_literal: true

module ErrorsHelper
  attr_reader :errors

  def init_errors
    @errors = []
  end
end
