Rails.application.routes.draw do

 devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get "/" => 'homes#top'
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end

  scope module: :public do
    root to:"homes#top"
    get "/about" => 'homes#about'
    get "/customers/my_page" => 'customers#show'
    get "/customers/information/edit" => 'customers#edit'
    patch "/customers/informaiton" => 'customers#update'
    get "/customers/unsubscribe" => 'customers#unsubscribe'
    patch "/customers/withdraw" => 'customers#withdraw'
    post "orders/confirm" => 'orders#confirm', as:'confirm_order'
    get "/orders/complete" => 'orders#complete'

    resources :items, only: [:index, :show]
    # resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      delete :destroy_all, on: :collection
    end
    resources :orders, only: [:new, :create, :index, :show]


  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
