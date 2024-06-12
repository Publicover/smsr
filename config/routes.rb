Rails.application.routes.draw do
  post 'auth/login', to: 'authentications#authenticate'

  resources :sms_texts, except: [:new, :edit]

  root 'sms_texts#index'
end
