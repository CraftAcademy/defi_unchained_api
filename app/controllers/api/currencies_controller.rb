class Api::CurrenciesController < ApplicationController
  def index
    nomics = Rails.application.credentials.nomics
    response = RestClient.get("https://api.nomics.com/v1/currencies/ticker?key=#{nomics}&ids=BTC,ETH,XRP, ADA, LTC, DOT&interval=1d")
    res_body = JSON.parse(response.body)
    res_filtered = res_body.map do |coin|
      {
        name: coin['name'],
        logo: coin['logo_url'],
        price: coin['price'],
        change: coin['1d']['price_change_pct']
      }
    end
    render json: {
      currencies: res_filtered
    }
  end
end
