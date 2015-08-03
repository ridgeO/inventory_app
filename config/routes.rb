Rails.application.routes.draw do

  root "pages#home"
  get "locations/:id/items/new" => "items#new"
  get "locations/:id/items/" => "items#index"
  get "edit" => "items#edit"
  get "items/:id/checkin" => "statuses#checkin"
  get "items/:id/checkout" => "statuses#checkout"
  get "create" => "statuses#create"
  get "/auth/google_oauth2/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  resources :items
  resources :statuses
  resources :locations

end
