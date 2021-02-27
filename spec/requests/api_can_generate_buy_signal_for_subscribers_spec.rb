RSpec.describe 'GET /api/buy_signals', type: :request do
  describe 'successfully as subscriber' do
    let!(:subscriber) { create(:user, subscriber: true) }
    let(:subscriber_headers) {subscriber.create_new_auth_token}
    before do
      get '/api/buy_signals',
          { headers: subscriber_headers }
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with a buy signal' do
      expect(response_json['signal']['coin']).to eq 'Ethereum'
    end

    it 'responds with a logo for the coin' do
      expect(response_json['signal']['logo']).to eq 'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg'
    end
  end

  describe 'unsuccessfully as non-subscriber' do
    let!(:user) {create(:user)}
    let(:user_headers) {user.create_new_auth_token}
    before do
      get '/api/buy_signals',
          { headers: user_headers }
    end

    it 'responds with a 401' do
      expect(response).to have_http_status 401
    end

    it 'responds with appropriate error message' do
      expect(response_json['errors']).to eq 'You need to be a subscribe to view this'
    end

  end
end
