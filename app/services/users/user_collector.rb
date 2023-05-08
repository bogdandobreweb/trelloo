# frozen_string_literal: true

module Users
  class UserCollector
    def initialize(user)
      @user = user
    end

    def call
      @user
    end
  end
end
