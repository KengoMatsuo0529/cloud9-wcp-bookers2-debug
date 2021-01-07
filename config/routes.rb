Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users

  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "follow" => "relationships#follow"
    get "follower" => "relationships#follower"
  end
  resources :books, only: [:new, :create, :edit, :index, :show, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end