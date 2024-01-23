Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to:"homes#top"
    resources :items, only: [:index, :show]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:index, :update, :destory, :create]
    resources :orders, only: [:new, :create, :index, :show]

    get "/about" => 'homes#about'
    get "/customers/unsubscribe" => 'customers#unsubscribe'
    patch "/customers/withdraw" => 'customers#withdraw'
    delete "/cart_items/destroy_all" => 'cart_items#destroy_all'
    post "/orders/confirm" => 'orders#confirm'
    get "/orders/complete" => 'orders#complere'

  end


  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
    get "/admin/top" => 'sessions#top'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
