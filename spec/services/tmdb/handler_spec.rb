# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tmdb::Handler do
  describe('#get') do
    let(:process) { instance_double('Tmdb::Process') }
    let(:expected_result) { TmdbMovieFixture::API_RESPONSE }

    before :each do
      allow(Tmdb::Process).to receive(:new).with(type_of_media, resource).and_return(process)
      allow(process).to receive(:get).and_return(expected_result)
    end

    context 'with a type of media `movie`' do
      let(:type_of_media) { 'movie' }
      let(:resource) { TmdbMovieFixture::TITLE }

      it 'returns a list of a resource' do
        expect(described_class.get(type_of_media, resource)).to include_json(expected_result)
      end
    end
  end
end
