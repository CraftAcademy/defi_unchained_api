class Api::CurrenciesController < ApplicationController
  def index
    nomics = Rails.application.credentials.nomics
    response = RestClient.get("https://api.nomics.com/v1/currencies/ticker?key=#{nomics}&ids=BTC,ETH,XRP, ADA, LTC, DOT&interval=1d")
    binding.pry
  end
end
