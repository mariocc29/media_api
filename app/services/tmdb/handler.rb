module Tmdb
  class Handler
    def self.get(type_of_media, ressource_name)
      process = Tmdb::Process.new(type_of_media, ressource_name)
      process.get
    end
  end
end