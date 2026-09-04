Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  root 'tasks#index'
  resources :tasks, except: [:show, :edit]

  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :create, :update, :destroy]
    end
  end
end
