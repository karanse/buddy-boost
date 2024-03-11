Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  root "pages#home"
  get '/legal', to: "pages#legal"
  get '/profile', to: "pages#profile"
  get  '/my-achievements', to: "pages#my_achievements"

  resources :goals, only: [:create, :show, :index] do
    resources :matches, only: [:new, :create]
  end
  resources :matches, only: [:show, :edit, :update, :index] do
    resources :tasks, only: [:new, :create, :index]
    resources :chatrooms, only: [:show, :create] do
      resources :messages, only: :create
    end
  end

  resources :tasks, only: [:edit, :update]
  resources :goals, only: [:edit, :update]
  resources :goals, only: :destroy, as: :delete_goal

end
