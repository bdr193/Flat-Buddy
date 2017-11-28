Rails.application.routes.draw do

  resources :flats, only: [:show, :new, :edit] do
    resources :rooms, only: [:index, :show, :new, :edit]
  end

  resources :viewings, only: [:index, :show, :new, :edit]
  resources :requests, only: [:index, :show, :new, :edit]

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
