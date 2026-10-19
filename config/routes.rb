Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # PROTOTYPE (throwaway): Live updates without leaking hands
  scope "prototype/live_updates", controller: "prototype/live_updates", as: :prototype_live_updates do
    get "/", action: :show, as: ""
    get "seats/:seat", action: :seat, as: :seat
    post "seats/:seat/play", action: :play, as: :play
    post "deal", action: :deal, as: :deal
    post "autoplay", action: :autoplay, as: :autoplay
    patch "settings", action: :settings, as: :settings
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
