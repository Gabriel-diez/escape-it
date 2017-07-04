Rails.application.routes.draw do
  resources :devices
  resources :games do
    resources :steps
  end
  devise_for :users

  root to: "games#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
