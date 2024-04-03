require 'swagger_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  path '/api/v1/movies' do
    get 'Retrieves a list of movies' do
      produces 'application/json'
      parameter name: :name, in: :query, type: :string
      response '200', 'Returns a list of movies' do
        schema '$ref' => '#/components/schemas/movies'

        let(:handler) { instance_double('Tmbd::Handler') }
        let(:expected_response) { TmdbMovieFixture::API_RESPONSE }
        let(:name) { TmdbMovieFixture::TITLE }

        before do
          allow(Tmdb::Handler).to receive(:get).and_return(expected_response)
        end
        
        run_test! do |response|
          expect(response).to be_successful
          expect(JSON.parse(response.body)).to include_json(expected_response)
        end
      end
      response '400', 'Raises a bad request' do
        let(:name) { nil }

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end