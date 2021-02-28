RSpec.describe 'GET /api/subscriptions' do
  describe 'client can check if user is subscriber (false)' do
    let!(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    before do
      get '/api/subscriptions',
          headers: auth_headers
    end

    it 'responds with subscriber false' do
      expect(response_json['subscriber']).to eq false
    end
  end

  describe 'client can check if user is subscriber (true)' do
    let!(:user) { create(:user, subscriber: true) }
    let(:auth_headers) { user.create_new_auth_token }
    before do
      get '/api/subscriptions',
          headers: auth_headers
    end

    it 'responds with subscriber true' do
      expect(response_json['subscriber']).to eq true
    end
  end
end
