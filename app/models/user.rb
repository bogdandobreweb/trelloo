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

end
