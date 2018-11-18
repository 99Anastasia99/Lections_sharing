Rails.application.routes.draw do
  get 'comments/create'
  resources :lections do
  #  post 'comments', to: "comments#create"
   resources :comments, only: [:create, :destroy]
  end
  root to: 'pages#home'
  devise_for :users
  resources :users, only: [:update, :show, :destroy]
  get '/tagged', to: "lections#tagged", as: :tagged
  resources :tags
end
