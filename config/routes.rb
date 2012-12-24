ImgSeek::Application.routes.draw do
  
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
    resources :api, :only => [] do
      get 'v1', :on => :collection
      get 'v2', :on => :collection
      get 'v3', :on => :collection
    end
  end
  
  namespace :api do
    namespace :v2 do
      resources :pictures, :only => [:create, :show]
      resources :places, :only => [:create, :show] do
        get 'mp3', :on => :member
        post 'search', :on => :collection
      end
    end
    
    namespace :v3 do
      resources :pictures, :only => [:create, :show]
      resources :places, :only => [:create, :show] do
        get 'mp3', :on => :member
        post 'search', :on => :collection
      end
    end
  end
end
