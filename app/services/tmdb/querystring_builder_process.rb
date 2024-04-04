# frozen_string_literal: true

module Tmdb
  class QuerystringBuilderProcess
    def initialize(params)
      @params = params
    end

    # Builds a query string using the provided parameters.
    # @return [String] The built query string.
    def build
      query_params = {
        api_key: Rails.application.config.tmdb[:api_key],
        query: @params[:name]
      }

      @params.each do |key, value|
        next if key == :name

        query_params[key] = value
      end

      URI.encode_www_form(query_params)
    end
  end
end
