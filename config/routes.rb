TestFoundation::Application.routes.draw do
  # get "test/index" => 'test#index'
  # get "test/test"
  # root 'test#index'

  
  # get "users/new"
  
  root 'static_pages#home'
  # match '/signup', to: 'users#new', via: 'get'

  match '/about' => 'static_pages#about', via: 'get' #both syntax work
  match '/help', to: 'static_pages#help', via: 'get'
  match'/contact', to: 'static_pages#contact', via: 'get'
  resources :users
  # resources :sessions, :only => [:new, :create, :destroy]

  match '/signin' => 'sessions#new', via: 'get'
  match '/signout' => 'sessions#destroy', via: 'delete'
  match '/sessions' => 'sessions#create', via: 'post'
  # resources :sessions, only: [:new, :create, :destroy] #Also works
  
  #match '/', to: 'static_pages#home', via: 'get'
end

#    Prefix Verb   URI Pattern               Controller#Action
#     users GET    /users(.:format)          users#index
#           POST   /users(.:format)          users#create
#  new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#      user GET    /users/:id(.:format)      users#show
#           PATCH  /users/:id(.:format)      users#update
#           PUT    /users/:id(.:format)      users#update
#           DELETE /users/:id(.:format)      users#destroy
#      root GET    /                         static_pages#home
#    signup GET    /signup(.:format)         users#new
#     about GET    /about(.:format)          static_pages#about
#      help GET    /help(.:format)           static_pages#help
#   contact GET    /contact(.:format)        static_pages#contact













#   Prefix Verb URI Pattern                     Controller#Action
#                 root GET  /                               static_pages#home
#    static_pages_home GET  /static_pages/home(.:format)    static_pages#home
#    static_pages_help GET  /static_pages/help(.:format)    static_pages#help
#   static_pages_about GET  /static_pages/about(.:format)   static_pages#about
# static_pages_contact GET  /static_pages/contact(.:format) static_pages#contact


# Prefix Verb URI Pattern        Controller#Action
#    root GET  /                  static_pages#home
#   about GET  /about(.:format)   static_pages#about
#    help GET  /help(.:format)    static_pages#help
# contact GET  /contact(.:format) static_pages#contact

