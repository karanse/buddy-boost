Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "custom_sessions" }
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
  end

  resources :tasks, only: [:edit, :update]
end
