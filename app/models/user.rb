# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :board_subscriptions
  has_many :boards, through: :board_subscriptions
  has_many :roles
  has_many :stories
  has_many :comments

  def has_board_subscription?(board_id)
    board_subscriptions.exists?(board_id:)
  end

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end
end
