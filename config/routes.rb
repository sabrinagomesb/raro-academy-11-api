Rails.application.routes.draw do
  devise_for :usuarios, ActiveAdmin::Devise.config
  begin
    ActiveAdmin.routes(self)
  rescue StandardError
    ActiveAdmin::DatabaseHitDuringLoad
  end

  namespace :api do
    namespace :v1 do
      get '/', to: 'api#index'

      post :auth, to: 'authentication#create'
      get :auth, to: 'authentication#fetch'

      resources :campeonatos, only: %i[index create show] do
        get 'ranking', to: 'campeonatos#ranking'

        resources :rodadas, only: %i[index show] do
          resources :jogos, only: [:index]
          resources :palpites, only: [:index, :create_or_update] do
            collection do
              get :index
              put '/', to: 'palpites#create_or_update'
            end
          end
        end
      end
    end
  end
end
