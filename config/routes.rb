Rails.application.routes.draw do

  root "pages#main"
  get "new" => "items#new"
  get "index" => "items#index"
  get "edit" => "items#edit"
  post "items/:id/checkin" => "items#checkin"
  get "items/:id/checkout" => "items#checkout"
  get "/auth/google_oauth2/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  resources :items

end
