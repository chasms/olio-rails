Rails.application.routes.draw do
	resources :accounts, only: [:index, :create]
	resources :addons, only: [:index, :show]
	resources :categories, only: [:index]
	get '/categories/:name', to: 'categories#show'
	resources :registrations, only: [:create]
	post '/signup', to: 'registrations#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
