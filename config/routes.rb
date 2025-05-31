Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # プロフィール編集ページ用のカスタムルート
  get 'users/edit_profile', to: 'users#edit_profile', as: :edit_user_profile

  resources :users, only: [:show, :edit, :update]
  get 'home/index'
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
