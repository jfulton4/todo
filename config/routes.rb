Rails.application.routes.draw do
  devise_for :users

  root 'tasks#index'
  resources :tasks, except: [:show, :edit]

  namespace :api do
    resources :tasks, only: [:index, :create, :update, :destroy]
  end
end
