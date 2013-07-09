Librarian::Application.routes.draw do
  resources :books, only: [:new, :create, :show]
  resources :users, only: [:new, :create]
  resources :sessions, only: [:create]

  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy'

  resources :shelves, only: [:new, :create, :show]

  root :to => 'reading_materials#index'
end
