Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :teams, only: [:index, :show, :create]
      resources :player, only: [:index, :show, :create]
      post 'player/:name', to: "player#change_team"
    end
  end
end
