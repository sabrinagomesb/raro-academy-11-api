Rails.application.routes.draw do
  devise_for :usuarios, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/', to: 'api#index'

      post :auth, to: 'authentication#create'
      get :auth, to: 'authentication#fetch'

      resources :campeonatos, only: [:index, :show]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
