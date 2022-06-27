Rails.application.routes.draw do
  root 'users#home'
  devise_for :users
  #resources :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  #link albums to users
  resources :users do
    resources :albums do
      resources :photos do
        member do
          delete :delete_user_album_photos
       end
      end
    end
  end
  #delete '/users/:user_id/albums/:album_id/photos/:id/delete_user_album_photos'=>  'photos#delete_user_album_photos'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end