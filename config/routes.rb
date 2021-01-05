Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users

  resources :users, only: [:show, :index, :edit, :update]
  resources :books, only: [:new, :create, :edit, :index, :show, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end
end