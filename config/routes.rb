Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :workers, only: %i[create destroy] do
        member do
          get :work_orders
        end
      end
      resources :work_orders, only: %i[index create] do
        member do
          post 'assign_worker/:worker_id', to: 'work_orders#assign_worker'
        end
      end
    end
  end
end
