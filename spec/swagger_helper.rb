# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'TMDB API V1',
        version: 'v1'
      },
      components: {
        schemas: {
          movies: {
            type: 'object',
              properties: {
                page: { type: 'integer' },
                results: { 
                  type: 'array',
                  items: {
                    type: 'object',
                    properties: {
                      adult: { type: 'boolean' },
                      backdrop_path: { type: 'string' },
                      genre_ids: { 
                        type: 'array',
                        items: { type: 'integer' }
                      },
                      id: { type: 'integer' },
                      original_language: { type: 'string' },
                      original_title: { type: 'string' },
                      overview: { type: 'string' },
                      popularity: { type: 'integer' },
                      poster_path: { type: 'string' },
                      release_date: { type: 'string' },
                      title: { type: 'string' },
                      video: { type: 'boolean' },
                      vote_average: { type: 'integer' },
                      vote_count: { type: 'integer' },
                    }
                  }
                },
                total_pages: { type: 'integer' },
                total_results: { type: 'integer' }
              }
          },
        }
      },
      paths: {},
      servers: [
        {
          url: ENV.fetch('APP_URL', 'http://localhost')
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :json
end
