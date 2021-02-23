class Api::MarketsController < ApplicationController
  def index
    nomics = Rails.application.credentials.nomics
    begin
      response = RestClient.get("https://api.nomics.com/v1/market-cap/history?key=#{nomics}&start=#{params['date']}")
      res_body = JSON.parse(response.body)
      res_body.each do |day|
        day['timestamp'] = day['timestamp'].to_datetime.strftime('%d/%m')
      end
      render json: {
        market_data: res_body
      }
    rescue RestClient::UnprocessableEntity
      render json: {
        message: "External API couldn't handle your request"
      }, status: 422
    end
  end
end