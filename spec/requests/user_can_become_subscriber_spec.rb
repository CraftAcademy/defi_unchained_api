RSpec.describe 'POST /api/subscriptions', type: :request do
  let!(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'user successfully becomes subscriber' do
    before do
      post '/api/subscriptions',
           params: {
             stripeToken: StripeMock.create_test_helper.generate_card_token
           },
           headers: auth_headers
    end

    it 'responds with a 200' do
      expect(response).to have_http_status 200
    end

    it 'responds with an object of paid with value of true' do
      expect(response_json['paid']).to eq true
    end

    it 'is expected to change user to subscribe' do
      expect(user.reload.subscriber?).to eq true
    end
  end

  describe 'unsuccessfully' do
    before do
      StripeMock.prepare_card_error(:card_declined, :new_charge)
      post '/api/subscriptions',
           params: {
             stripeToken: StripeMock.create_test_helper.generate_card_token
           },
           headers: auth_headers
    end

    it 'responds with a 422' do
      expect(response).to have_http_status 422
    end

    it 'responds with an error message' do
      expect(response_json['message']).to eq 'The card was declined'
    end

    it 'is expected to NOT change subscriber to true' do
      expect(user.reload.subscriber?).to eq false
    end
  end
end
