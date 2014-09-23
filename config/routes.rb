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
 

  match '/signin' => 'sessions#new', via: 'get'
  match '/signout' => 'sessions#destroy', via: 'delete'
  match '/sessions' => 'sessions#create', via: 'post'

   resources :users
  # resources :sessions, :only => [:new, :create, :destroy] #Also works, but custom named routes change
   resources :microposts, only: [:create, :destroy]

  
  #match '/', to: 'static_pages#home', via: 'get'
end

#     Prefix Verb   URI Pattern               Controller#Action
#       root GET    /                         static_pages#home
#      about GET    /about(.:format)          static_pages#about
#       help GET    /help(.:format)           static_pages#help
#    contact GET    /contact(.:format)        static_pages#contact
#     signin GET    /signin(.:format)         sessions#new
#    signout DELETE /signout(.:format)        sessions#destroy
#   sessions POST   /sessions(.:format)       sessions#create
#      users GET    /users(.:format)          users#index
#            POST   /users(.:format)          users#create
#   new_user GET    /users/new(.:format)      users#new
#  edit_user GET    /users/:id/edit(.:format) users#edit
#       user GET    /users/:id(.:format)      users#show
#            PATCH  /users/:id(.:format)      users#update
#            PUT    /users/:id(.:format)      users#update
#            DELETE /users/:id(.:format)      users#destroy
# microposts POST   /microposts(.:format)     microposts#create
#  micropost DELETE /microposts/:id(.:format) microposts#destroy





