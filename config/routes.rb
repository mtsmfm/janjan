Rails.application.routes.draw do
  root to: redirect('/rooms')

  resources :rooms do
    resources :joins
    resources :actions, only: :create
    resources :games
  end

  namespace :api do
    resource :game do
      resources :actions, only: :create
    end
    resource :user, only: :show
  end

  mount ActionCable.server => '/cable'

  resource :debug, only: :show do
    post :load_fixture
  end if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
