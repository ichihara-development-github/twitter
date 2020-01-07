Rails.application.routes.draw do
  get 'todo/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "todos#index"
  
  post "complete", to: "todos#complete"
  get "done", to: "todos#done"
  post "undo", to: "todos#undo"
  post "tweet", to: "todos#tweet"
  
  resources :todos
end