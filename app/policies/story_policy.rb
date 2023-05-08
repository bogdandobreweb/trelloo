# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  def index?
    view_stories? || user.admin?
  end

  def show?
    view_story?
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
      %i[id name description column_id user_id board_id]
    elsif manager?
      %i[id name description column_id]
    else
      []
    end
  end

  def permitted_attributes_for_create
    %i[name description column_id]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def admin?
    user.has_role?('admin')
  end

  def manager?
    user.has_role?('manager')
  end

  def developer?
    user.has_role?('developer')
  end

  def view_stories?
    user.has_role?('admin') || user.has_board_subscription?(record.board_id)
  end

  def view_story?
    user.has_role?('admin') || user.has_board_subscription?(record.board_id)
  end
end
