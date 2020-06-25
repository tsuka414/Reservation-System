Rails.application.routes.draw do

  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # 拠点ページ
  resources :bases
  
  # ユーザー
  resources :users do
    collection { post :import }
    member do
      get 'working_employees'
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
    end
    resources :attendances, only: :update do
      member do
        get 'edit_overwork_request'
        patch 'update_overwork_request'
      end
      collection do
        get 'edit_notice_overwork'
        patch 'update_notice_overwork'
      end
    end
  end
end