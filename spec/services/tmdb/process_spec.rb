# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tmdb::Process do
  subject { described_class.new(type_of_media, resource) }

  shared_examples 'Tmdb::Process behavior' do
    describe '#initialize' do
      it 'initializes with type_of_media and resource_name', :aggregate_failures do
        url = subject.instance_variable_get(:@url)
        query_params = CGI.parse(url.query)

        expect(url).to be_an_instance_of(URI::HTTPS)
        expect(url.path).to include("/#{type_of_media}")
        expect(query_params['query']).to include(resource)
      end
    end

    describe '#get' do
      let(:response) { TmdbMovieFixture::API_RESPONSE }

      before do
        allow_any_instance_of(Net::HTTP)
          .to receive(:request)
          .and_return(OpenStruct.new(read_body: response.to_json))
      end

      it 'sends a GET request to the API and returns parsed JSON response' do
        expect(subject.get).to include_json(response)
      end
    end

    describe 'private methods' do
      describe '#connect_api' do
        it 'yields an HTTP object' do
          subject.send(:connect_api) do |http|
            expect(http).to be_an_instance_of(Net::HTTP)
          end
        end
      end

      describe '#request' do
        it 'returns a Net::HTTP::Get object', :aggregate_failures do
          request = subject.send(:request)
          expect(request).to be_an_instance_of(Net::HTTP::Get)
          expect(request['accept']).to eq('application/json')
        end
      end
    end
  end

  context 'with a type of media `movie`' do
    let(:type_of_media) { 'movie' }
    let(:resource) { TmdbMovieFixture::TITLE }

    it_behaves_like 'Tmdb::Process behavior'
  end
end
