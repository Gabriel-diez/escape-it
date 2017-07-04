Rails.application.routes.draw do
  resources :games do
    post 'start', as: :start
    resources :steps do
      resources :devices, only: [] do
        get 'validate'
      end
    end
    post 'reset', as: :reset
  end
  devise_for :users, :controllers => { registrations: 'registrations' }

  get '/callback', to: "sensits#callback", as: :callback
  get '/refresh', to: "sensits#refresh", as: :refresh

  root to: "statics#index"
end
