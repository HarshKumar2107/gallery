Rails.application.routes.draw do
  devise_for :users
  
  # get 'albums/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :albums do
    member do
      delete :purge_img
    end
  end
  
end
