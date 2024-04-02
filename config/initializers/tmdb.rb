Rails.application.config.tmdb = {
  search_url: "#{ENV['TMDB_URL']}/search",
  api_key: ENV['API_KEY']
}