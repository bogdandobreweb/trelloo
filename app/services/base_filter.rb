# frozen_string_literal: true

class BaseFilter < CommonBase
  def call(options: {})
    model.all(options)
  end
end
