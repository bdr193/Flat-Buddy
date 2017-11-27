Rails.application.routes.draw do

  resources :users
  resources :flats do
    resources :rooms, only: [:index, :show, :new, :edit]
  end

  resources :viewings, only: [:index, :show, :new, :edit]

  resources :requests, only: [:index, :show, :new, :edit]

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

  # get 'viewings/index'

  # get 'viewings/show'

  # get 'viewings/new'

  # get 'viewings/edit'

  # get 'requests/index'

  # get 'requests/show'

  # get 'requests/new'

  # get 'requests/edit'

  # get 'flats/show'

  # get 'flats/new'

  # get 'flats/edit'

  # get 'rooms/index'

  # get 'rooms/show'

  # get 'rooms/new'

  # get 'rooms/edit'
