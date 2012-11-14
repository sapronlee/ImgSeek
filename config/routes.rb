require 'api'

ImgSeek::Application.routes.draw do
  
  mount ImgSeek::API => "/"
  
  root :to => 'home#index'
  
  namespace :admin do
  	root :to => "home#index"
  	resources :scenics, :except => [:show] do
      resources :places
    end
    resources :places do
      resources :pictures
    end
    resources :pictures do
      get 'store', :on => :collection
    end
  end
end
