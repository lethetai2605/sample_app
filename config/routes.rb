# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get 'messages/create'
  resources :roles
  devise_for :users
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  get '/users/:id/export', to: 'users#export', as: 'export'
  patch '/users/read/:id', to: 'users#read_notification', as: 'users_read'
  patch '/users/read/micropost/:id', to: 'microposts#read_post', as: 'users_read_post'
  post '/users/:id/report', to: 'reports#create', as: 'report'
  get 'list_report', to: 'reports#index', as: 'list_report'
  patch 'list_report/block/:block_id', to: 'reports#block', as: 'block_user'
  get 'list_report/search/', to: 'reports#search', as: 'report_search'
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]

  resources :microposts do
    resources :replies
    resources :reactions
  end

  resources :messages, only: %i[new create]
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
end
