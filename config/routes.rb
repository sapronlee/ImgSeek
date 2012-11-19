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
    resources :pictures
  end
  
  namespace :api2 do
    resources :places, :only => [] do
      get 'audio', :on => :member
    end
  end
end
