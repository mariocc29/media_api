# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tmdb::Handler do
  describe('#get') do
    let(:querystring) { instance_double('Tmdb::QuerystringBuilderProcess') }
    let(:process) { instance_double('Tmdb::Process') }
    let(:expected_result) { TmdbMovieFixture::API_RESPONSE }

    before :each do
      allow(Tmdb::QuerystringBuilderProcess).to receive(:new).with(params).and_return(querystring)
      allow(Tmdb::Process).to receive(:new).with(type_of_media, querystring).and_return(process)
      allow(process).to receive(:get).and_return(expected_result)
    end

    context 'with a type of media `movie`' do
      let(:type_of_media) { 'movie' }
      let(:params) { {name: TmdbMovieFixture::TITLE} }

      it 'returns a list of a resource' do
        expect(described_class.get(type_of_media, params)).to include_json(expected_result)
      end
    end
  end
end
