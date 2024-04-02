# frozen_string_literal: true

module Tmdb
  class Handler
    def self.get(type_of_media, resource_name)
      process = Tmdb::Process.new(type_of_media, resource_name)
      process.get
    end
  end
end
