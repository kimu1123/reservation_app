Rails.application.routes.draw do
  get 'reservations/index'
  get 'rooms/index'
  get 'homes/index'
  get 'users/new'
  devise_for :users, controllers: { registrations: 'users/registrations' }
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  
   resources :users do
   end
   root 'homes#index'
   get 'users/show'
   get 'users/edit'
   resources :rooms do
   end

  resources :reservations do
    member do
      post 'confirm'
      get 'confirm'
    end
  end
end