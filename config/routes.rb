Rails.application.routes.draw do
  
  get 'welcome/index'
  root 'cats#index'
  resources :cats do 
    resources :cat_rental_requests, only: [:new, :create] do
      member do
        post :approve
        post :deny
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
