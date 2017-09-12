
Rails.application.routes.draw do


  namespace :api do 
    namespace :v1 do  
    	root "auth#ping"
    	resources :users do       	
        	resources :books
      end
	    resources :books
      resources :auth
      post '/auth', to: "auth#login"
      post '/auth/refresh', to: "auth#refresh"

    end
  end
end



