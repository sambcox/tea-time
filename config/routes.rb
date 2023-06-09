Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers, only: :create do
        scope module: 'customers' do
          resources :subscriptions, only: :index
        end
      end
      resources :teas, only: :create
      resources :subscriptions, only: [:create, :update]
    end
  end
end
