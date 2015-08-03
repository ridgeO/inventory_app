Rails.application.routes.draw do

  root "pages#home"
  get "/auth/google_oauth2/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  post "/locations/:location_id/items/new" => "items#create"
  post "/locations/:location_id/items/:id/edit" => "items#update"
  resources :locations do
    resources :items do
      collection {post :import}
      resources :statuses
      get "checkin" => "statuses#checkin", :as => "checkin"
      get "checkout" => "statuses#checkout", :as => "checkout"
    end
  end

end
