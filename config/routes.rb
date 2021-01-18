Rails.application.routes.draw do
  get 'change_histories/index'
  get 'daily_balances/show'
  # static_pages
  get "/home",  to: "static_pages#home"
  get "/help",  to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/details", to: "static_pages#details"
  root "static_pages#home"

  # users
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i[new create edit update] do
    resources :daily_balances, only: :show, param: :record_date
    resource :images, only: %i[edit update], module: :users
    resource :image_initializations, only: :update, module: :users
    resource :self_categories, only: %i[new create], module: :users
  end

  # book_records
  resources :book_records, :except => :new

  resources :change_histories, only: %i[destroy index]

  # post
  resources :posts, only: %i[create destroy index]

  # sessions
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
