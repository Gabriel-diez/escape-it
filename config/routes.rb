Rails.application.routes.draw do
  resources :devices
  resources :games do
    resources :steps
  end
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: "statics#index"
end
