Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 自分用プロフィール
  get  '/users/profile',      to: 'users#my_profile',   as: :show_user_profile
  get  '/users/profile/edit', to: 'users#edit_profile', as: :edit_user_profile

  # 他ユーザーのプロフィール表示
  resources :users, only: [:show, :edit, :update]

  resources :skill_offerings, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :reservations,    only: [:new, :create, :show, :index, :update] do
    member do
      get :approved
    end

    resources :messages, only: [:create]
  end

  root 'home#index'
  get 'home/index'
end
