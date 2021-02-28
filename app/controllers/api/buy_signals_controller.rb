class Api::BuySignalsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_subscriber?

  def index
    weather_key = Rails.application.credentials.open_weather
    response = RestClient.get("api.openweathermap.org/data/2.5/weather?lat=23.806078&lon=11.288452&appid=#{weather_key}&units=metric")
    daily_signal = getSignal(JSON.parse(response.body))
    render json: {
      signal: daily_signal
    }
  end

  private

  def is_subscriber?
    return if current_user.subscriber?

    render json: {
      errors: 'You need to be a subscribe to view this'
    }, status: 401
  end

  def getSignal(response)
    if response['weather'].first['main'] === 'Rain'
      {
        coin: 'Bitcoin',
        logo: 'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg'
      }
    else
      {
        coin: 'Ethereum',
        logo: 'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg'
      }
    end
  end
end
