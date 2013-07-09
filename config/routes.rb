Librarian::Application.routes.draw do
  resources :users, only: [:create]
  match '/signup' => 'users#new'

  resources :sessions, only: [:create]
  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy'

  resources :shelves, only: [:new, :create, :show] do
    resources :books, only: [:new, :create, :show]
  end

  match '/library' => 'shelves#index'

  root :to => redirect('/signin')
end
