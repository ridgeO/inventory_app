Rails.application.routes.draw do

  root "pages#main"
  get "new" => "items#new"
  get "index" => "items#index"
  resources :items

end
