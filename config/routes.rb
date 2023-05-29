Rails.application.routes.draw do
  devise_for :usuarios, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  namespace :api do
    namespace :v1 do
      resources :campeonatos
    end
  end
end
