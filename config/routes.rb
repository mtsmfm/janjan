Rails.application.routes.draw do
  with_options to: 'welcome#index' do
    root
    get :login
    get :rooms
    get :room
    get :game
  end

  namespace :api do
    resource :user, only: %i(show create)
    resource :game, only: %i(show create) do
      resources :actions, only: [], param: :type do
        member do
          post :create
        end
      end
    end
    resource :room, only: :show

    resources :rooms, only: %i(index create) do
      resources :joins, only: :create
    end
  end

  resource :debug, only: :show do
    post :load_fixture
  end if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
