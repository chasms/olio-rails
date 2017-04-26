Rails.application.routes.draw do
	resources :accounts, only: [:index, :create]
	resources :categories, only: [:index]
	get '/categories/:name', to: 'categories#show'
	resources :registrations, only: [:create]
	resources :creations
	post '/signup', to: 'registrations#create'
	post '/login', to: 'sessions#create'
	get '/addons', to: 'categories#addons'
	get '/me', to: 'accounts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
