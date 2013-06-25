Librarian::Application.routes.draw do
  resources :books, only: [:new, :create, :show]
  resources :users, only: [:new, :create]

  match '/signin' => 'sessions#new'

  root :to => 'reading_materials#index'
end
