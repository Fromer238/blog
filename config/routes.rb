Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :stories do
    resources :comments, only: [:create]
  end
  root 'pages#index'
  get '@:username/:story_id', to: 'pages#show', as: 'story_page'
  get '@:username/', to: 'pages#user', as: 'user_page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
