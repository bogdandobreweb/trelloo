class BoardPolicy < ApplicationPolicy
  def show?
    view_stories?
  end

  def index?
    view_stories?
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

  def view_stories?
    has_role?("admin") || user.board_subscriptions.exists?(board_id: record.id)
  end

  def has_role?(role_name)
    user.roles.exists?(name: role_name)
  end

  public :view_stories?

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
