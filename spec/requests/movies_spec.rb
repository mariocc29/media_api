require 'rails_helper'

RSpec.describe MoviesController, type: :request do
  include Rack::Test::Methods

  describe('MoviesController') do

    let(:params) do
      {
        name: 'Avengers'
      }
    end

    context 'when the params are correct' do
      it "retreives a list of movies" do
        get '/movies', params
        expect(last_response.status).to eql(200)
      end
    end

    context 'when the params are correct' do
      let(:params) { {} }

      it "raises a Bad Request Error" do
        get '/movies', params
        expect(last_response.status).to eql(400)
      end
    end

  end

end