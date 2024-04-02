class MoviesController < ApplicationController
  def index
    movies = Tmdb::Handler.get('movie', movie_params[0])
    render json: movies, status: :ok
  end

  private

  def movie_params
    params.required(:name)
  end
end
