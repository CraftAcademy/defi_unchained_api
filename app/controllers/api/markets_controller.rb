class Api::MarketsController < ApplicationController
  def index
    nomics = Rails.application.credentials.nomics 
    
    response = RestClient.get("https://api.nomics.com/v1/market-cap/history?key=#{nomics}&start=#{params["date"]}")
    render status: 200
  end
end
