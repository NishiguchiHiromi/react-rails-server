Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resource :sample, only: [:show]
      resource :session, only: [:show, :create, :destroy]
      resources :users, only: [:index, :show, :create, :update, :destroy] do
        get "search_form", on: :collection
      end
      resources :hobbies, only: [:index, :show, :create, :update, :destroy]
      # mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
end
