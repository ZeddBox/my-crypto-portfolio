require 'sidekiq/web'

Rails.application.routes.draw do
  get '/presentation', to: 'static#_landingpage'
  resources :currencies, path: 'crypto'
  post '/crypto/update', to: 'currencies#update'

  resources :purchases do 
    get :autocomplete_currency_crypto, on: :collection
  end

    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  devise_for :users
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
