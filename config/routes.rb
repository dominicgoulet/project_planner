Rails.application.routes.draw do
  root "dashboard#index"

  resources :reports
  resources :suppliers
  resources :materials
  resources :tasks
  resources :steps
  resources :payment_methods
  resources :expenses
end
