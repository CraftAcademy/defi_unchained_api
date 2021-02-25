class Api::NewsController < ApplicationController
  before_action :authenticate_user!
  def index
    news_key = Rails.application.credentials.news
    response = RestClient.get("http://newsapi.org/v2/everything?q=crypto&from=#{params['date']}&sortBy=publishedAt&apiKey=#{news_key}")
    res_body = JSON.parse(response.body)
    res_filtered = res_body['articles'].map do |article| 
      {
        title: article['title'],
        urlToImage: article['urlToImage'],
        url: article['url'],
        description: article['description'],
        date: article['publishedAt']
      
      }
      end
      render json: {
        articles: res_filtered 
      } 
  end  
end
