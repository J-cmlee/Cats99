Rails.application.routes.draw do
  
  get 'welcome/index'
  root 'cats#index'
  resources :cats
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
