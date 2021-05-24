Rails.application.routes.draw do
  devise_for :users
  root "posts#index"

  get '/posts/search' => 'posts#search', :as => 'search_posts'

  resources :posts do
    resources :comments
  end
end
