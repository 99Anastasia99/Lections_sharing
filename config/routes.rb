Rails.application.routes.draw do
  resources :lections
  root to: 'pages#home'
  devise_for :users
  resources :users, only: [:update, :show, :destroy]
  get '/tagged', to: "lections#tagged", as: :tagged
end
