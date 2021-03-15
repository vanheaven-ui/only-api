Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json } do
    resources :users do
      resources :publications
      resources :comments
    end
    resources :categories, except: [:destroy]
  end
end
