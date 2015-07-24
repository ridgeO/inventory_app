Rails.application.routes.draw do

  root "pages#main"
  get "new" => "items#new"
  get "index" => "items#index"
  get "edit" => "items#edit"
  post "items/:id/checkin" => "items#checkin"
  get "items/:id/checkout" => "items#checkout"
  resources :items

end
