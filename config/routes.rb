Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :labels, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
end
