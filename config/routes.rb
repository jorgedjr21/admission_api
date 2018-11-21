Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :students, only: %i[index create update destroy]
      resources :admissions, only: [:index]
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end
end
