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
    patch "users/withdraw" => "users#withdraw", as: "withdraw"
    resources :users, only: [:edit, :show, :update,] do
      member do
        get :follows, :followeds, :favorites
      end
      resource :relationships, only: [:create, :destroy]
    end
    resources :posts do
      resources :comments, except: [:edit, :update]
    end
    resources :favorites, only: [:create, :destroy]
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
