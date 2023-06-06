Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:index, :create]
      end
    end
  end
end
