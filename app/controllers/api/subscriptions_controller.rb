class Api::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.update(subscriber: true)
    render json: {
      subscriber: true,
      message: 'Congratulations!'
    }
  end

  def index
    if current_user.subscriber?
      render json: {
        subscriber: true,
        email: current_user.email
      }
    else
      render json: {
        subscriber: false
      }
    end
  end
end
