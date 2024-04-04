# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      def index
        movies = Tmdb::Handler.get('movie', movie_params )
        render json: movies, status: :ok
      end

      private

      def movie_params
        params.required(:name)
        params.permit(%i[name include_adult language primary_release_year page region year])
      end
    end
  end
end
