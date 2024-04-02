Rails.application.routes.draw do
  
  get '/movies', to: 'movies#index', defaults: { format: 'json' }

end
