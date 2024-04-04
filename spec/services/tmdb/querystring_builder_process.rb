# frozen_string_literal: true

require 'rails_helper'
require 'uri'

RSpec.describe Tmdb::QuerystringBuilderProcess do
  describe '#build' do
    let(:api_key) { 'api_key' }
    let(:params) { { name: 'some_name', page: 1, other_param: 'value' } }
    let(:encoded_name) { URI.encode_www_form_component('some_name') }
    let(:encoded_query) { "api_key=#{api_key}&query=#{encoded_name}&page=1&other_param=value" }
    
    before do
      allow(Rails.application.config.tmdb).to receive(:[]).with(:api_key).and_return(api_key)
    end

    it 'returns the correct query string' do
      query_builder = Tmdb::QuerystringBuilderProcess.new(params)
      expect(query_builder.build).to eq(encoded_query)
    end

    context 'when name contains special characters' do
      let(:params) { { name: 'special_†_characters', page: 1 } }
      let(:encoded_name) { URI.encode_www_form_component('special_†_characters') }
      let(:encoded_query) { "api_key=#{api_key}&query=#{encoded_name}&page=1" }

      it 'encodes special characters properly' do
        query_builder = Tmdb::QuerystringBuilderProcess.new(params)
        expect(query_builder.build).to eq(encoded_query)
      end
    end

    context 'when page parameter is not provided' do
      let(:params) { { name: 'some_name' } }
      let(:encoded_name) { URI.encode_www_form_component('some_name') }
      let(:encoded_query) { "api_key=#{api_key}&query=#{encoded_name}" }

      it 'returns the correct query string without page parameter' do
        query_builder = Tmdb::QuerystringBuilderProcess.new(params)
        expect(query_builder.build).to eq(encoded_query)
      end
    end
  end
end
