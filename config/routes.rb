Rails.application.routes.draw do
  devise_for :users
  root "posts#index"

  get '/posts/search' => 'posts#search', :as => 'search_posts'

  get '/users/show' => 'user#show', :as => 'show_users'

  resources :posts do
    resources :comments
  end
end
