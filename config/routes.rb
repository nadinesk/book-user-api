
Rails.application.routes.draw do

root "books#ping"
  namespace :api do 
    namespace :v1 do  
        root "books#ping"
        resources :books
    end
  end
end