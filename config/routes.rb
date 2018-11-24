Rails.application.routes.draw do
  get '/', to: 'home#index', as: 'admission_api_index'
  root     to: 'home#index'

  #API ROUTES
  namespace :api do
    namespace :v1 do
      resources :students,    only: %i[index create show update destroy] do
        resources :admissions,only: %i[index create show update destroy]
        resources :billings,  only: %i[index create show update destroy] do
          resources :bills,   only: %i[index show] do
            resources :payments, only: %i[index show]
          end
        end
      end
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end
end
