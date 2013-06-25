Librarian::Application.routes.draw do
  resources :books, only: [:new, :create, :show]
  resources :users, only: [:new, :create]
  root :to => 'reading_materials#index'
end
