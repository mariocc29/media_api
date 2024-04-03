module TmdbMovieFixture
  TITLE = Faker::Movie.title.encode('ASCII', 'UTF-8', invalid: :replace, undef: :replace, replace: '')
  
  API_RESPONSE = {
    page: 1,
    results: [
      {
        "adult": Faker::Boolean.boolean,
        "backdrop_path": Faker::File.file_name,
        "genre_ids": [ Faker::Number.digit ],
        "id": Faker::Number.digit,
        "original_language": "en",
        "original_title": TmdbMovieFixture::TITLE,
        "overview": Faker::Movie.quote,
        "popularity": Faker::Number.between(from: 100_000, to: 200_000),
        "poster_path": Faker::File.file_name,
        "release_date": Faker::Date.between(from: '2014-09-23', to: '2014-09-25').strftime("%Y-%m-%d"),
        "title": TmdbMovieFixture::TITLE,
        "video": Faker::Boolean.boolean,
        "vote_average": Faker::Number.between(from: 1000, to: 10_000),
        "vote_count": Faker::Number.between(from: 100, to: 200)
      }
    ],
    total_pages: 1,
    total_results: 1
  }
end