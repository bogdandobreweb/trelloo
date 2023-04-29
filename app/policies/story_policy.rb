class StoryPolicy < ApplicationPolicy
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
    admin? || manager? || (developer? && record.user_id == user.id && valid_column_id_change?)
  end

  def destroy?
    admin?
  end

  def permitted_attributes
    if admin?
      [:id, :name, :description, :column_id, :user_id, :board_id]
    elsif manager?
      [:id, :name, :description, :column_id]
    else
      []
    end
  end

  def permitted_attributes_for_create
    [:name, :description, :column_id, :board_id]
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

  def valid_column_id_change?
    if record.column_id.present?
      return (record.column_id - column_id.to_i).abs == 1
    end
    true
  end
end
