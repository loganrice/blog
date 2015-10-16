Rails.application.routes.draw do
  resources :posts

  root to: 'posts#index'
  devise_for :users
  resources :users

  get '/sitemap.xml', to: 'sitemaps#index'
end
