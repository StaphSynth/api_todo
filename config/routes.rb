Rails.application.routes.draw do
  root to: 'pages#index'
  namespace :api do
    namespace :v1 do
      resources :tasks, only: %i(index show create update destroy)
    end
  end
end
