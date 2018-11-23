Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :students,    only: %i[index create show update destroy] do
        resources :admissions,only: %i[index create show update destroy]
        resources :billings,  only: %i[index create show update destroy]
      end
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end
end
