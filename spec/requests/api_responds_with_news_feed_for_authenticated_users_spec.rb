RSpec.describe 'GET /api/news', type: :request do
  let!(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  describe 'successfully with authenticated user' do
    before do
      get '/api/news',
          params: '2021-02-20',
          headers: auth_headers
    end

    it 'returns a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'returns an array of articles' do
      expect(response_json['articles']).to be_instance_of(Array)
    end

    it 'an article contains the expected title' do
      expect(response_json['articles'].first['title']).to eq 'Is Blockchain the Future of Art Collecting?'
    end

    it 'an article contains the expected image url' do
      expect(response_json['articles'].first['urlToImage']).to eq 'https://wwd.com/wp-content/uploads/2021/02/Installation-View37.jpg?w=640&h=415&crop=1'
    end

    it 'an article contains the expected url' do
      expect(response_json['articles'].first['url']).to eq 'https://wwd.com/eye/lifestyle/ry-david-bradley-the-hole-gallery-nyc-nft-blockchain-1234727774/'
    end

    it 'an article contains the expected description' do
      expect(response_json['articles'].first['description']).to eq 'Artist Ry David Bradley is selling works from his new gallery show at The Hole in New York as physical art and nonfungible tokens through digital art marketplace SuperRare.'
    end

    it 'an article contains the expected date' do
      expect(response_json['articles'].first['date']).to eq '2021-02-25T12:30:42Z'
    end
  end

  describe 'unsuccessfully with unauthenticated user' do
    before do
      get '/api/news',
          params: '2021-02-20'
    end

    it 'should respons with a 401' do
      expect(response).to have_http_status 401

      
    end
  end
end
