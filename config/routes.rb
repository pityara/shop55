Rails.application.routes.draw do
  resources :docs do
    get :sign, on: :member
  end
  get 'on_sign', to: 'docs#on_sign_docs', as: 'on_sign'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  resources :users
  get 'hello/index'
  root to: 'hello#index'
end
