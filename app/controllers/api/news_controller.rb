class Api::NewsController < ApplicationController
  before_action :authenticate_user!
  before_action :valid_date?
  def index
    news_key = Rails.application.credentials.news
    response = RestClient.get("http://newsapi.org/v2/everything?q=crypto&from=#{params['date']}&sortBy=publishedAt&apiKey=#{news_key}")
    res_body = JSON.parse(response.body)
    res_filtered = filterResponse(res_body)
    render json: {
      articles: res_filtered
    }
  end

  private

  def valid_date?
    return if params['date'] == (Time.now - 5.days).strftime('%Y-%m-%d')

    render json: {
      errors: 'Date param is faulty'
    }, status: 422
  end

  def filterResponse(response)
    response['articles'].map do |article|
      {
        title: article['title'],
        urlToImage: article['urlToImage'],
        url: article['url'],
        description: article['description'],
        date: DateTime.parse(article['publishedAt']).strftime('%Y-%m-%d')
      }
    end
  end
end
