Rails.application.routes.draw do
  devise_for :usuarios, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  namespace :api do
    namespace :v1 do
      get "/", to: "api#index"

      post :auth, to: "authentication#create"
      get :auth, to: "authentication#fetch"

      resources :campeonatos, only: [:index, :create, :show] do
        resources :rodadas, only: [:index, :show] do
          resources :jogos, only: [:index]
          put "/palpites", to: "palpites#cria_ou_atualiza_palpites"
        end
      end
    end
  end
end
