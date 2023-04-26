Rails.application.routes.draw do
  devise_for :users
  
  # resources :users do
  #   resources :board_memberships, only: [:index, :create, :destroy]
  #   resources :boards, only: [:index, :create]
  # end

  get '/users/:id', to: 'users#show'
  
  resources :boards do
    resources :columns do
      resources :stories 
    end
  end
  
  root to: "boards#index"
end
