class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    admin? || manager?
  end

  def update?
    admin? || manager? || (developer? && record.user_id == user.id)
  end

  def destroy?
    admin?
  end

  def permitted_attributes
    if admin?
      [:id, :body, :story_id]
    elsif manager?
      [:id, :body]
    else
      []
    end
  end

  def permitted_attributes_for_create
    [:body, :story_id]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def admin?
    has_role?("admin")
  end

  def manager?
    has_role?("manager")
  end

  def developer?
    has_role?("developer")
  end

  def has_role?(role_name)
    user.roles.exists?(name: role_name)
  end
end