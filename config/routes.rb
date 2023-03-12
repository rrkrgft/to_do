Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions, only: [:new, :create, :destroy ]
  namespace :admin do
    resources :users
  end
  resources :labels, only: [:new, :create, :index, :edit, :update, :destroy ]
end
