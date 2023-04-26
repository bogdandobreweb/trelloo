class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
  
    # def index
    #   users = Users::ViewService.call
    #   render json: users
    # end
  
    def show
      render json: @user
    end
  
    # def create
    #   user = Users::CreateService.call(user_params)
    #   if user.valid?
    #     render json: user, status: :created
    #   else
    #     render json: user.errors, status: :unprocessable_entity
    #   end
    # end
  
    # def update
    #   Users::UpdateService.call(@user, user_params)
    #   if @user.valid?
    #     render json: @user
    #   else
    #     render json: @user.errors, status: :unprocessable_entity
    #   end
    # end
  
    # def destroy
    #   Users::DestroyService.call(@user)
    #   head :no_content
    # end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    # def user_params
    #   params.require(:user).permit(:email, :password)
    # end
  end