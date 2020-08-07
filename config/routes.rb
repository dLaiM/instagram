Rails.application.routes.draw do
 root 'pages#home'
  get 'users/show'
	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations'
	}

 devise_scope :user do
	 get '/users/sign_out' => 'devise/sessions#destroy'
 end

 resources :posts, only: %i(new create index) do
	 resources :photos, only: %i(create)
	 resources :likes, only: %i(create destroy)
	 resources :comments, only: %i(create destroy)
 end

 get '/users/:id', to: 'users#show', as: 'user'

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
