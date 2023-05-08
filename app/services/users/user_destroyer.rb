# frozen_string_literal: true

module Users
  class UserDestroyer
    def initialize(user)
      @user = user
    end

    def call
      @user.destroy
    end
  end
end
