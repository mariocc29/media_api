# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tmdb::Process do
  subject { described_class.new(type_of_media, querystring) }

  let(:querystring) { instance_double('Tmdb::QuerystringBuilderProcess') }

  before :each do
    allow(Tmdb::QuerystringBuilderProcess).to receive(:new).and_return(querystring)
    allow(querystring).to receive(:build).and_return( query_encoded )
  end

  shared_examples 'Tmdb::Process behavior' do
    describe '#initialize' do
      it 'initializes with type_of_media and querystring_builder_process', :aggregate_failures do
        expect(subject.send(:type_of_media)).to eq(type_of_media)
        expect(subject.send(:querystring_builder_process)).to eq(querystring)

        url = subject.instance_variable_get(:@url)
        expect(url).to be_an_instance_of(URI::HTTPS)
        expect(url.path).to include("/#{type_of_media}")
      end
    end

    describe '#get' do
      context 'when data is in cache' do
        let(:redis_key) { 'mock_redis_key' }
        let(:cached_data) { mock_response }

        before do
          allow(subject).to receive(:generate_redis_key).and_return(redis_key)
          allow(Rails.cache).to receive(:exist?).with(redis_key).and_return(true)
          allow(Rails.cache).to receive(:read).with(redis_key).and_return(cached_data)
        end

        it 'returns data from cache' do
          expect(subject.get).to eq(cached_data)
        end
      end

      context 'when data is not in cache' do
        let(:redis_key) { 'mock_redis_key' }
        let(:tmdb_data) { mock_response }

        before do
          allow(subject).to receive(:generate_redis_key).and_return(redis_key)
          allow(Rails.cache).to receive(:exist?).with(redis_key).and_return(false)
          allow(subject).to receive(:fetch_tmdb_data).and_return(tmdb_data)
          allow(Rails.cache).to receive(:write)
        end

        it 'fetches data from Tmdb API and caches it', :aggregate_failures do
          expect(subject.get).to eq(tmdb_data)
          expect(Rails.cache).to have_received(:write).with(redis_key, tmdb_data, expires_in: 1.day)
        end
      end
    end

    describe 'private methods' do
      describe '#generate_redis_key' do
        it 'generates a Redis cache key based on type_of_media and querystring_builder_process' do
          expect(subject.send(:generate_redis_key)).to eq(Digest::SHA256.hexdigest("#{type_of_media}:#{query_encoded}"))
        end
      end

      describe '#fetch_tmdb_data' do
        before do
          mock_connect_api = instance_double('http', body: mock_response.to_json, is_a?: Net::HTTPSuccess)
          allow(subject).to receive(:connect_api).and_return(mock_connect_api)          
        end

        it 'fetches data from Tmdb API and returns parsed JSON' do
          expect(subject.send(:fetch_tmdb_data)).to eq(JSON.parse(mock_response.to_json))
        end
      end

      describe '#connect_api' do        
        it 'yields an HTTP object' do          
          subject.send(:connect_api) do |http|
            expect(http).to be_an_instance_of(Net::HTTP)
          end
        end
      end

      describe '#build_request' do
        it 'returns a Net::HTTP::Get object', :aggregate_failures do
          request = subject.send(:build_request)
          expect(request).to be_an_instance_of(Net::HTTP::Get)
          expect(request['accept']).to eq('application/json')
        end
      end
    end
  end

  context 'with a type of media `movie`' do
    let(:type_of_media) { 'movie' }
    let(:mock_response) { TmdbMovieFixture::API_RESPONSE }
    let(:query_encoded) { "query=#{TmdbMovieFixture::TITLE}" }

    it_behaves_like 'Tmdb::Process behavior'
  end
end
