# frozen_string_literal: true
Rails.application.routes.draw do
  root 'home#root'

  post 'send',          to: 'contacts#send_mail', as: 'contact'
  post 'search',        to: 'flights#search', as: 'search'
  post 'hook',          to: 'payments#hook', as: 'hook'

  scope path: '/sessions', controller: :sessions do
    post 'login',       to: 'sessions#create'
    delete 'logout',    to: 'sessions#destroy'
  end

  scope path: '/user', controller: :users do
    get 'home',         to: 'users#home', as: 'user_home'
    get 'profile',      to: 'users#profile', as: 'user_profile'
    post 'signup',      to: 'users#create'
  end

  scope path: '/bookings', controller: :bookings do
    post 'select',      to: 'bookings#select', as: 'select'
    get ':id/confirm',  to: 'bookings#confirm', as: 'confirm_booking'
    get 'manage',       to: 'bookings#manage', as: 'manage_bookings'
    post 'retrieve',    to: 'bookings#retrieve', as: 'retrieve_booking'
  end

  scope controller: :home do
    get 'schedule',     to: 'home#schedule', as: 'schedule'
    get 'home',         to: 'home#index', as: 'home'
  end

  resources :users
  resources :bookings
  resources :sessions, only: [:create, :destroy]
end
