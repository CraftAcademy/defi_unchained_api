RSpec.describe 'GET api/currencies', type: :request do
  describe 'successfully' do
    before do
      get '/api/currencies'
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with expected length of crypto list' do
      expect(response_json['currencies'].count).to eq 6
    end

    it 'response contains the name' do
      expect(response_json['currencies'].first['name']).to eq "Bitcoin"
    end

    it 'response with rounded price' do
      expect(response_json['currencies'].first['price']).to eq 49844.33
    end

    it 'response with %' do
      expect(response_json['currencies'].first['change']).to eq 6.7
    end
  end

  describe 'unsuccessfully' do
    before do
      Webmock.stub_request(:get, 'https://api.nomics.com/v1/currencies/ticker?ids=BTC,ETH,XRP,%20ADA,%20LTC,%20DOT&interval=1d&key=aaf997cff4f9e722484a7a24ca78e9d3')
      .to_return(status: 200, body: currencies_fixture, headers: {})
    end
  end
end