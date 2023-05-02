class BoardPolicy < ApplicationPolicy
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
    admin? || manager?
  end

  def destroy?
    admin?
  end

  def permitted_attributes
    if admin?
      [:id, :name]
    elsif manager?
      [:name]
    else
      []
    end
  end

  def permitted_attributes_for_create
    [:name]
  end

  private

  def admin?
    has_role?("admin")
  end

  def manager?
    has_role?("manager")
  end

  def has_role?(role_name)
    user.roles.exists?(name: role_name)
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
