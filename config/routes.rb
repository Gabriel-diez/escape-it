Rails.application.routes.draw do
  resources :games do
    post 'start', as: :start
<<<<<<< HEAD
    resources :steps do
      resources :devices, only: [] do
        get 'validate'
      end
    end
=======
    post 'reset', as: :reset
    resources :steps
>>>>>>> 1493ee31c94f84e5407fe9914108b533075a9c1a
  end
  devise_for :users, :controllers => { registrations: 'registrations' }

  get '/callback', to: "sensits#callback", as: :callback
  get '/refresh', to: "sensits#refresh", as: :refresh

  root to: "statics#index"
end
