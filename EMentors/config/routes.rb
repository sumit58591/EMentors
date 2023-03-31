Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home/index'
  get 'main/index'
  root 'main#index'
  get 'students/dashboard/index'
  get 'thanks', to: 'charges#thanks', as: 'thanks'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  
  # resources :payments
  resources :charges, only: [:new, :create]
  scope module: :teacher do
    resources :courses do
      resources :topics
    end
    resources :subscribers
  end

  scope module: :student do
    resources :dashboard 
    resources :purchases
    resources :subscriptions
  end
end
