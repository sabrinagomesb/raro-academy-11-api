Rails.application.routes.draw do
  devise_for :usuarios, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  namespace :api do
    namespace :v1 do
      get '/', to: 'api#index'

      post :auth, to: 'authentication#create'
      get :auth, to: 'authentication#fetch'
    end
  end
end
