Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'book_comments/create'
  get 'book_comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  root 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users

  resources :users, only: [:show, :index, :edit, :update] do
    resources :relationship, only: [:create, :destroy]
  end
  resources :books, only: [:new, :create, :edit, :index, :show, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end