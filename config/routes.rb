Rails.application.routes.draw do
  root to: redirect('/rooms')

  resources :rooms do
    resources :joins
    resources :actions, only: :create
  end

  match '/websocket', to: ActionCable.server, via: [:get, :post]

  get :debug, to: 'debug#index' if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
