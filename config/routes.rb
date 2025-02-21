Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_scope :user do
    get 'guest_login' => 'public/sessions#guest_login'
  end

  devise_for :admins,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #ユーザー用ルーティング
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    get "mypage" => "users#mypage", as: "mypage"
    get "search" => "searches#search"
    patch "users/withdraw" => "users#withdraw", as: "withdraw"
    resources :users, only: [:edit, :show, :update,] do
      member do
        get :follows, :followeds, :favorites
      end
      resource :relationships, only: [:create, :destroy]
    end
    resources :posts do
      resources :comments, except: [:edit, :update, :index]
    end
    resources :favorites, only: [:create, :destroy]
    resources :rooms, only: [:create, :show, :index]
    resources :messages, only: [:show, :create, :destroy]
    resources :groups do
      resource :groupusers, only: [:create, :destroy]
      resource :permits, only: [:create, :destroy]
    end
  end

  #管理者用ルーティング
  namespace :admin do
    root to: "homes#top"
    patch "users/withdraw" => "users#withdraw"
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:show, :destroy]
    end
    resources :users, only: [:index, :show] do
      member do
        get :follows, :followeds, :favorites
      end
    end
    resources :groups, only: [:index, :show, :destroy]
  end

end
