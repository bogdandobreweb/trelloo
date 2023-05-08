class BoardSubscriptionsController < ApplicationController
  before_action :authenticate_user!, :authorize_admin!

  def create
    subscription_creator = BoardSubscriptions::SubscriptionCreator.new(subscription_params).call

    if subscription_creator.errors.empty?
      render json: BoardSubscriptions::SubscriptionPresenter.new(subscription_creator.id).as_json, status: :created
    else
      render json: { errors: subscription_creator.errors }, status: :bad_request
    end
  end

  def update
    authorize @board_subscription

    updater = BoardSubscriptionUpdater.new(@board_subscription, board_subscription_params)

    if updater.call
      render json: BoardSubscriptions::BoardSubscriptionPresenter.new(@board_subscription.id).as_json, status: :ok
    else
      render json: { errors: updater.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_board_subscription
    @board_subscription = BoardSubscription.find(params[:id])
  end

  def board_subscription_params
    params.require(:board_subscription).permit(:id, :board_id, :user_id)
  end

  def authorize_admin!
    return if current_user && current_user.admin?

    render json: { errors: ['You do not have permission to perform this action.'] }, status: :forbidden
  end
end
