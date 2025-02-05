Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #ユーザー用ルーティング
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    get "mypage" => "homes#mypage", as: "mypage"
    resources :users, only: [:edit, :show, :update, :destroy] do
      member do
        get :follows, :followeds, :favorites
      end
      resource :relationships, only: [:create, :destroy]
    end
    resources :posts
    resources :favorites, only: [:create, :destroy]
    resources :comments, except: [:edit, :update]
    resources :rooms, only: [:create, :show] do
      resources :messages, only: [:create, :destroy]
    end
    resources :groups, except: [:create, :edit, :update] do
      resource :groupusers, only: [:create, :destroy]
    end
  end

  #管理者用ルーティング
  namespace :admin do
    root to: "homes#top"
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :show, :destroy]
  end

end
