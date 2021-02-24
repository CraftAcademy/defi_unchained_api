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

    it 'contains the appropriate data' do
      expect(response_json['currencies'].first['name']).to eq "Bitcoin"
      expect(response_json['currencies'].first['price']).to eq "49844.33422620"
    end

  end
end