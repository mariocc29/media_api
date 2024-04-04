# frozen_string_literal: true

module Tmdb
  class Handler

    # Retrieves data of a specified type of media from Tmdb.
    # @param [String] type_of_media The type of media to retrieve (e.g., "movie", "tv").
    # @param [Hash] params The parameters for the request.
    # @return [Object] The retrieved data.
    def self.get(type_of_media, params)
      querystring_builder = Tmdb::QuerystringBuilderProcess.new(params)
      process = Tmdb::Process.new(type_of_media, querystring_builder)
      process.get
    end
  end
end
