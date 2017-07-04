Rails.application.routes.draw do
  resources :devices
  resources :games do
    resources :steps
  end
  devise_for :users, :controllers => { registrations: 'registrations' }

  get '/callback', to: "sensits#callback", as: :callback
  get '/refresh', to: "sensits#refresh", as: :refresh

  root to: "statics#index"
end
