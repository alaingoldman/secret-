Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources "products"
  
  get  "purchase/:id" => "products#purchase", as: "purchase"
  post "purchase/:id" => "products#charge",   as: "charge"
end
