Rails.application.routes.draw do
  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :posts

  root to: 'posts#index'
  devise_for :users
  resources :users

  get '/sitemap.xml', to: 'sitemaps#index'
end
