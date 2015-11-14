Rails.application.routes.draw do
  root to: redirect('/rooms')

  resources :rooms do
    resources :joins
    resources :actions, only: [] do
      collection do
        post :start
        post :draw
        post :discard
        post :self_pick
      end
    end
  end

  match '/websocket', to: ActionCable.server, via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
