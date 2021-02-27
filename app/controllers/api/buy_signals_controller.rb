class Api::BuySignalsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_subscriber?
  def index
    
  end

  private

  def is_subscriber?
    return if current_user.subscriber?

    render json: {
      errors: 'You need to be a subscribe to view this'
    }, status: 401
  end

end


