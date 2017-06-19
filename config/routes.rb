Rails.application.routes.draw do
  get 'items/new'

  get 'items/update'

  root to: 'static_pages#home'
  resources :sites

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
