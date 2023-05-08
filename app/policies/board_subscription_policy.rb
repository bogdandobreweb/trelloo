class BoardSubscriptionPolicy < ApplicationPolicy
  def admin?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
