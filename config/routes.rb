# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users

  resources :users, only: %i[index show]

  resources :boards do
    resources :stories do
      resources :comments
    end
  end
  resources :columns
  root to: 'boards#index'
end
