Rails.application.routes.draw do
  resources :lections
  root to: 'pages#home'
  devise_for :users
end
