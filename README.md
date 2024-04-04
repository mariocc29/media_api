# Movie Search Engine
**Circle Medical Test Ruby backend**

### Overview

The Movie Search Engine is a RESTful service that allows evaluating the quality of the code.

The purpose of this application is to connect to [TMDB API](https://developer.themoviedb.org/docs/getting-started) an APIRestful and get movie data. For the scope of this exercise, we will only get data from only one source, but in the future we would want to add multiple sources of data (ie, we might want to add books, music albums, etc.).

## Requirements

* The project is developed as a REST API.

### Constraints

1. To initialize the project, use the following command:

```bash
  rails new pokemon_api --api -d postgresql -T
```

## Technologies

The following technologies are used in this project:

||Version|Command for checking
|-|-:|-|
|ruby|3.2.3|ruby --version|
|rails|7.1.3.2|rails --version|

## Deployment

To deploy the application, follow these steps:

1. Install dependencies:

```bash
  bundle install
```

2. Start the server:

```bash
  bin/rails serve
```

## API Reference

To access the API documentation, perform the following steps:

1. Run the command:

```bash
  rake rswag:specs:swaggerize
```

2. Once the documentation is retrieved, go to (TMDB API v1 Docs)[localhost:3000/api/docs]

## Running Tests

Execute the following command to run the tests:

```bash
   bundle exec rspec spec/
```

## Solution Approach

The solution for building the TMDB API involves the following steps:

1. **Decoupling Core Logic**: Our foremost objective is to ensure the development of clean, maintainable code. To achieve this, we've segregated the logic pertaining to the movies endpoint into a dedicated service. This approach not only facilitates the retrieval of requested resource information but also lays the groundwork for seamless querying of future resources.

2. **Cache Server Implementation**: In order to optimize performance and minimize reliance on external API calls, we've seamlessly integrated Redis as our cache server. By leveraging Redis, we enhance the efficiency of our system, reducing latency and improving overall user experience.

2. **Documentation Generation:** We integrate Rswag to automatically generate Swagger-compliant documentation for our API. This ensures that our API endpoints are well-documented and easy to explore. Taking advantage of the gem, it allows us to create tests at the same time as we are creating the documentation.

3. **Testing Strategy:** We employ RSpec and related gems for behavior-driven development (BDD) and testing. RSpec Rails provides a robust framework for testing Rails applications, while Rack Test allows us to test Rack applications with a simple API. Additionally, we use RSpec JSON Expectations for validating JSON responses in our tests.

4. **Code Quality:** To maintain code quality and adherence to best practices, we utilize RuboCop, a linter for Ruby code. RuboCop helps us enforce consistent coding styles and identify potential issues in our codebase.

## Installed Gems

The following gems are installed for the project:

- `byebug`: Debugging tool for Ruby.
- `dotenv-rails`: Loads environment variables from a .env file into ENV when the Rails app initializes.
- `faker`: Generates fake data for testing purposes
- `rspec-json_expectations`: Integrate 'rspec/json_expectations' gem for additional JSON-related expectations in RSpec.
- `rspec-rails`: Behavior-driven development for Ruby on Rails applications
- `rswag-api`: Adds Swagger API documentation to Rails APIs using RSpec.
- `rswag-specs`: Provides tools to document APIs with RSpec-like syntax and generate Swagger JSON files.
- `rswag-ui`: Provides a UI for interacting with and testing Rails APIs documented with Swagger.
- `rubocop`: Linter for Ruby code.
