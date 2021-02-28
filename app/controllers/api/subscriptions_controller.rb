class Api::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    paid = perform_payment()
    if paid
      current_user.update(subscriber: true)
      render json: {
        paid: true
      }
    end
    rescue StandardError => e
      render json: {
        message: e.message
      }, status: 422
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

  private

  def perform_payment
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params['stripeToken'],
      description: "Welcome to DeFi Unchained!"
    )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 75*100,
      currency: 'sek'
    )
    charge.paid
  end
end
