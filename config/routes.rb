Rails.application.routes.draw do
  root to: 'pages#index', format: false
  resources :pages, except: [:index, :edit, :update], format: false
end
