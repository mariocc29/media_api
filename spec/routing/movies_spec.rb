require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :routing do

  describe('routing') do
    it "routes to #index" do
      expect(get: "/api/v1/movies").to route_to("api/v1/movies#index")
    end
  end

end