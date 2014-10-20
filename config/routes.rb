Rails.application.routes.draw do
  get "twiml" => "smses#twiml"

  post "welcome" => "smses#send_welcome_message"
  get "send_policy/:id" => "smses#send_policy"
  post "reminder" => "users#send_reminder"
  get "happened" => "meetups#index"

  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    root "devise/registrations#new"
    get "sign_up", to: "devise/registrations#new"
    get "sign_in", to: "devise/sessions#new"
    get "sign_out", to: "devise/sessions#destroy"
    get "thankyou", to: "users#thankyou"
  end

  resources :users do
    member do
      post "toggle_mute"
    end
  end
  resources :smses
  resources :meetups
end
