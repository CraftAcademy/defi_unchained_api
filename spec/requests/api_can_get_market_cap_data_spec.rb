RSpec.describe 'GET /api/markets',type: :request do

  describe 'successfully' do

    before do
      get '/api/markets',
      params: {
        date: '2021-02-16T14:13:31.364Z'
      }
      end

      it 'responds with a 200 status' do
        expect(response). to have_http_status 200
      end

    
  end
end