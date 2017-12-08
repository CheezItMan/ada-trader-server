Rails.application.routes.draw do
  resources :stocks, only: [:index, :show, :update, :destroy, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
