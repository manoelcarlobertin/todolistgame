Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "todo_lists#index"
  devise_for :users

  resources :todo_lists do
    resources :todo_items # cria URLs mais lógicas, como /todo_lists/1/todo_items/new
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
