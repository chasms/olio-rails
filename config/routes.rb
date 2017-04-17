Rails.application.routes.draw do
	resources :accounts, only: [:index]
	resources :addons, only: [:index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
