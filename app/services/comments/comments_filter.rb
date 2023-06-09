# frozen_string_literal: true

module Stories
  class StoriesFilter < BaseFilter
    def call(options: {})
      return model.all if options.blank?

      result = model
      result = result.where(user_id: options.user_id) if options.user_id.present?

      result
    end
  end
end
