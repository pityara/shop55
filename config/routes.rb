Rails.application.routes.draw do
  resources :docs do
    get :sign, on: :member
    get :refuse, on: :member
  end
  get 'my_docs', to: 'docs#my_docs', as: 'my_docs'
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
