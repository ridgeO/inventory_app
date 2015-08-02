Rails.application.routes.draw do

  root "pages#home"
  get "new" => "items#new"
  get "index" => "items#index"
  get "edit" => "items#edit"
  get "items/:id/checkin" => "statuses#checkin"
  get "items/:id/checkout" => "statuses#checkout"
  get "/auth/google_oauth2/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  resources :items
  resources :statuses

end
