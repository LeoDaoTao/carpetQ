Rails.application.routes.draw do
  mount Crono::Web, at: '/crono'
  root 'dashboard#index'
  get  'login', to: 'sessions#new'
  get '/labels/addresses', to: 'labels#addresses', as: 'address_label'
  get 'invoices/:invoice_id/email', to: 'invoices#email_invoice', as: 'email_invoice'
  post 'twilio/forward_message' => 'twilio#messages'

  resources :messages
  resources :events
  resources :customers
  resources :invoices
  resources :notes
  resources :users
  resources :services
  resources :discounts
  resources :invoice_images
  resources :reminders
  resources :settings, only: [:index, :edit, :update]
  resources :labels
  resource  :session

end
