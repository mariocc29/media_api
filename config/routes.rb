Rails.application.routes.draw do
  root to: 'application#forbidden_exception', via: :all
  
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      get '/movies', to: 'movies#index', defaults: { format: 'json' }
    end
  end

  match '*path', to: 'application#route_not_found', via: :al
end
