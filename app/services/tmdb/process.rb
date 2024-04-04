# frozen_string_literal: true

require 'uri'
require 'net/http'

module Tmdb
  class Process

    # Initializes a new instance of Process.
    # @param [String] type_of_media The type of media to process (e.g., "movie", "tv").
    # @param [Tmdb::QuerystringBuilderProcess] querystring_builder_process The query string builder process.
    def initialize(type_of_media, querystring_builder_process)
      @url = URI("#{Rails.application.config.tmdb[:search_url]}/#{type_of_media}?#{querystring_builder_process.build}")
    end

    # Retrieves data from Tmdb API.
    # @return [Hash] The retrieved data.
    def get
      connect_api do |http|
        response = http.request(request)
        return JSON.parse(response.read_body)
      end
    end

    private

    attr_reader :url

    # Establishes connection to the Tmdb API.
    # @yield [Net::HTTP] http The HTTP connection object.
    def connect_api
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      yield http
    end

    # Constructs an HTTP GET request.
    # @return [Net::HTTP::Get] The constructed GET request.
    def request
      request = Net::HTTP::Get.new(@url)
      request['accept'] = 'application/json'
      request
    end
  end
end
