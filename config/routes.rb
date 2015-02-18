Rails.application.routes.draw do
  root to: 'pages#index', format: false
  resources :pages, only: [:index, :show], format: false
end
