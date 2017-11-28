Rails.application.routes.draw do

  resources :flats, only: [:show, :new, :edit] do
    resources :rooms, only: [:new, :edit]
  end
  resources :rooms, only: [:show, :index]
  resources :viewings, only: [:index, :show, :new, :edit] do
    resources :requests, only: [:new, :create]
  end

  resources :requests, only: [:index, :show, :edit]

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
