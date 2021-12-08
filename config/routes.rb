Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/merchants', to: 'merchants#index'
      get '/merchants/:merchant_id', to: 'merchants#show'
      get 'merchants/:merchant_id/items', to: 'merchant_items#index'


      get '/items/find_all', to: 'items#find'
      get '/items', to: 'items#index'
      get '/items/:item_id', to: 'items#show'
      post '/items', to: 'items#create'
      put '/items/:item_id', to: 'items#update'
      patch '/items/:item_id', to: 'items#update'
      delete '/items/:item_id', to: 'items#destroy'
      get '/items/:item_id/merchant', to: 'merchant_items#show'
    end
  end
end
