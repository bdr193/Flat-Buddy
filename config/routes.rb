Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"
  mount ActionCable.server => "/cable"


  resources :flats, only: [:show, :new, :edit] do
    resources :rooms, only: [:new, :edit]
  end
  resources :rooms, only: [:show, :index]
  resources :viewings, only: [:index, :show, :new, :edit] do
  end

  resources :requests, only: [:index, :show, :edit, :new, :create]
    resources :chat_rooms, only: [:show] do
      resources :messages, only: [:create]
    end

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users

  resources :profiles, only: [:new, :create, :show]

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
