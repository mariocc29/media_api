source "https://rubygems.org"

ruby "3.2.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

# Customization gems for the project
gem 'dotenv-rails' # Loads environment variables from a .env file into ENV when the Rails app initializes.
gem 'rswag-api' # Adds Swagger API documentation to Rails APIs using RSpec.
gem 'rswag-ui' # Provides a UI for interacting with and testing Rails APIs documented with Swagger.

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]

  # Customization gems for the project
  gem 'byebug' # Debugger for Ruby
  gem 'faker' # Generates fake data for testing purposes
  gem 'rspec-json_expectations' # Integrate 'rspec/json_expectations' gem for additional JSON-related expectations in RSpec.
  gem 'rspec-rails' # Behavior-driven development for Ruby on Rails applications
  gem 'rswag-specs' # Provides tools to document APIs with RSpec-like syntax and generate Swagger JSON files.
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"

  # Customization gems for the project
  gem 'rubocop' # Linter for Ruby code
end

