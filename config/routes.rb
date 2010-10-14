Shrink::Application.routes.draw do
  devise_for :users

  resources :projects do
    resources :notifications, :only => [:index, :show]
  end
  resources :users

  namespace :api do
    namespace :v1 do
      resources :notifications, :only => :create
    end
  end

  root :to => "projects#index"
end
