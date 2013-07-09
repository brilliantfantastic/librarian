Librarian::Application.routes.draw do
  resources :users, only: [:new, :create]
  resources :sessions, only: [:create]

  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy'

  resources :shelves, only: [:new, :create, :show] do
    resources :books, only: [:new, :create, :show]
  end

  root :to => 'reading_materials#index'
end
