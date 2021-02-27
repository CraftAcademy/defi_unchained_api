RSpec.describe 'POST /api/subscriptions', type: :request do
  describe 'user successfully becomes subscriber' do
    let!(:user) {create(:user)}
    let(:auth_headers) {user.create_new_auth_token}
    before do
      post '/api/subscriptions',
           headers: auth_headers
    end

    it 'responds with a 200' do
      expect(response).to have_http_status 200
    end

    it 'responds with a message' do
      expect(response_json['message']).to eq 'Congratulations!'
    end

    it 'is expected to change user to subscribe' do
      expect(user.reload.subscriber?).to eq true
    end
  end

  describe 'client can check if user is subscriber (false)' do
    let!(:user) {create(:user)}
    let(:auth_headers) {user.create_new_auth_token}
    before do
      get '/api/subscriptions',
          headers: auth_headers
    end

    it 'responds with subscriber false' do
      expect(response_json['subscriber']).to eq false
    end
  end

  describe 'client can check if user is subscriber (true)' do
    let!(:user) {create(:user, subscriber: true)}
    let(:auth_headers) {user.create_new_auth_token}
    before do
      get '/api/subscriptions',
          headers: auth_headers
    end

    it 'responds with subscriber true' do
      expect(response_json['subscriber']).to eq true
    end

    it 'responds with the users email' do
      expect(response_json['subscribe']).to eq 'user@gmail.com'
    end
  end
end
