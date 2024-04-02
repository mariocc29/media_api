# frozen_string_literal: true

require 'uri'
require 'net/http'

module Tmdb
  class Process
    def initialize(type_of_media, resource_name)
      resource_name = resource_name.encode('ASCII', 'UTF-8', invalid: :replace, undef: :replace, replace: '')
      @url = URI("#{Rails.application.config.tmdb[:search_url]}/#{type_of_media}?api_key=#{Rails.application.config.tmdb[:api_key]}&query=#{resource_name}")
    end

    def get
      connect_api do |http|
        response = http.request(request)
        return JSON.parse(response.read_body)
      end
    end

    private

    attr_reader :url

    def connect_api
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      yield http
    end

    def request
      request = Net::HTTP::Get.new(@url)
      request['accept'] = 'application/json'
      request
    end
  end
end
