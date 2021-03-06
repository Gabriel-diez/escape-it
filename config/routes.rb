Rails.application.routes.draw do
  resources :games do
    post 'start', as: :start
    post 'reset', as: :reset
    
    resources :steps do
      resources :devices do
        get 'validate'
        get 'sensors'
      end
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  get '/callback', to: "sensits#callback", as: :callback
  get '/refresh', to: "sensits#refresh", as: :refresh

  root to: "statics#index"
end
