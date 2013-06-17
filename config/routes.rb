Librarian::Application.routes.draw do
  resources :books, only: [:new, :create, :show]
  root :to => 'reading_materials#index'
end
