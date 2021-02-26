require 'coveralls'
Coveralls.wear_merged!('rails')

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'
require 'webmock/rspec'
WebMock.disable_net_connect!

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include ResponseJSON
  config.before(:each) do
    market_fixture = File.open("#{fixture_path}/market_cap_fixture.json").read
    stub_request(:get, 'https://api.nomics.com/v1/market-cap/history?key=aaf997cff4f9e722484a7a24ca78e9d3&start=2021-02-16T14:13:31.364Z')
      .to_return(status: 200, body: market_fixture, headers: {})
    stub_request(:get, 'https://api.nomics.com/v1/market-cap/history?key=aaf997cff4f9e722484a7a24ca78e9d3&start=')
      .to_return(status: 422, body: '', headers: {})
    stub_request(:get, 'https://api.nomics.com/v1/market-cap/history?key=aaf997cff4f9e722484a7a24ca78e9d3&start=today%207%20days%20ago')
      .to_return(status: 422, body: '', headers: {})

    currencies_fixture = File.open("#{fixture_path}/currencies_fixture.json").read
    stub_request(:get, 'https://api.nomics.com/v1/currencies/ticker?ids=BTC,ETH,XRP,%20ADA,%20LTC,%20DOT&interval=1d&key=aaf997cff4f9e722484a7a24ca78e9d3')
      .to_return(status: 200, body: currencies_fixture, headers: {})

    news_fixture = File.open("#{fixture_path}/crypto_news_fixture.json").read
    stub_request(:get, "http://newsapi.org/v2/everything?apiKey=18c7ceeb856b42bf8ac6c0624adbc52f&from=#{(Time.now - 5.days).strftime('%Y-%m-%d')}&q=crypto&sortBy=publishedAt")
      .to_return(status: 200, body: news_fixture, headers: {})
  end
end
