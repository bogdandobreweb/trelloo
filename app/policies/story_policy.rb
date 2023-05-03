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
    admin? || manager? || (developer? && record.user_id == user.id && valid_order_id_change?)
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

  def admin?
    user.has_role?("admin")
  end

  def manager?
    user.has_role?("manager")
  end

  def developer?
    user.has_role?("developer")
  end
  
  def view_stories?
    user.has_role?("admin") || user.has_board_subscription?(record.board_id)
  end

  def view_story?
    user.has_role?("admin") || user.has_board_subscription?(record.board_id) 
  end

  def valid_order_id_change?
    if record.order_id.present?
      return (record.order_id - order_id.to_i).abs == 1
    end
    true
  end
end
