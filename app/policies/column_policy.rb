# frozen_string_literal: true

class ColumnPolicy < ApplicationPolicy
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
      %i[id name order_id]
    elsif manager?
      %i[id name order_id]
    elsif developer?
      [:id]
    else
      []
    end
  end

  def permitted_attributes_for_create
    %i[name order_id]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def admin?
    user.has_role?('admin')
  end

  def manager?
    user.has_role?('manager')
  end

  def developer?
    user.has_role?('developer')
  end
  
  def has_role?(role_name)
    user.roles.any? { |role| role.name == role_name }
  end
end
