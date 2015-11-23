Rails.application.routes.draw do
  root to: redirect('/rooms')

  resources :rooms do
    resources :joins
    resources :actions, only: :create
    resources :games
  end

  match '/websocket', to: ActionCable.server, via: [:get, :post]

  resource :debug, only: :show do
  end if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
