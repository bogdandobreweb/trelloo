# frozen_string_literal: true

class RemoveUserIdFromBoards2 < ActiveRecord::Migration[7.0]
  def change
    remove_column :boards, :user_id
  end
end
