class BoardSubscriptionsController < ApplicationController
    before_action :set_user

    # def index
    #   @board_memberships = @user.board_memberships
    #   @boards = @board_memberships.map(&:board)
  
    #   render json: @boards, status: :ok
    # end
  
    def create
    end
  
    def destroy
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
end
