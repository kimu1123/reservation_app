Rails.application.routes.draw do
  get 'reservations/index'
  get 'rooms/index'
  get 'homes/index'
  get 'users/new'
  devise_for :users, controllers: { registrations: 'users/registrations' }
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'homes/index'
  get 'users/show'
  
  resources :rooms
  root 'homes#index'


  resources :reservations do
    member do
      post 'confirm'
      get 'confirm'
    end
  end
end
