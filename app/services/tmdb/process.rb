# frozen_string_literal: true

require 'uri'
require 'net/http'

module Tmdb
  class Process

    # Initializes a new instance of Process.
    # @param [String] type_of_media The type of media to process (e.g., "movie", "tv").
    # @param [Tmdb::QuerystringBuilderProcess] querystring_builder_process The query string builder process.
    def initialize(type_of_media, querystring_builder_process)
      @type_of_media = type_of_media
      @querystring_builder_process = querystring_builder_process
      @url = URI("#{Rails.application.config.tmdb[:search_url]}/#{@type_of_media}?#{@querystring_builder_process.build}")
    end

    # Retrieves data either from Redis cache or Tmdb API.
    # @return [Hash] The retrieved data.
    def get
      redis_key = generate_redis_key
      return Rails.cache.read(redis_key) if Rails.cache.exist?(redis_key)

      tmdb_data = fetch_tmdb_data
      Rails.cache.write(redis_key, tmdb_data, expires_in: 1.day) if tmdb_data
      tmdb_data
    end

    private

    attr_reader :type_of_media, :querystring_builder_process, :url

    # Generates a Redis cache key based on the query string.
    # @return [String] The generated Redis cache key.
    def generate_redis_key
      Digest::SHA256.hexdigest("#{@type_of_media}:#{@querystring_builder_process.build}")
    end

    # Fetches data from Tmdb API.
    # @return [Hash, nil] The retrieved data if successful, nil otherwise.
    def fetch_tmdb_data
      response = connect_api do |http|
        http.request build_request
      end
      
      return nil unless response.is_a?(Net::HTTPSuccess)
      
      JSON.parse(response.body)

    rescue StandardError => e
      Rails.logger.error("Error fetching data from Tmdb API: #{e.message}")
      nil
    end

    # Establishes connection to the Tmdb API.
    # @param [URI] url The URL to connect to.
    # @yield [Net::HTTP] http The HTTP connection object.
    def connect_api
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      yield http
    end

    # Constructs an HTTP GET request.
    # @return [Net::HTTP::Get] The constructed GET request.
    def build_request
      request = Net::HTTP::Get.new @url
      request['accept'] = 'application/json'
      request
    end
  end
end
