Rails.application.routes.draw do
  resources :grades
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'grades#index'
end
