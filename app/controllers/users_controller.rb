class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :authenticate_user!

  def index
    render json: Users::UsersPresenter.new(current_user).as_json
  end

  def show
    render json: Users::UserPresenter.new(current_user).as_json
  end

  def create; end

  def update; end

  def destroy; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
