TestFoundation::Application.routes.draw do
  # get "test/index" => 'test#index'
  # get "test/test"
  # root 'test#index'

  root 'static_pages#home'
  get "users/new"


  match '/signup', to: 'users#new', via: 'get'
  match '/about' => 'static_pages#about', via: 'get' #both syntax work
  match '/help', to: 'static_pages#help', via: 'get'
  match'/contact', to: 'static_pages#contact', via: 'get'
  
  #match '/', to: 'static_pages#home', via: 'get'
end

#    Prefix Verb URI Pattern          Controller#Action
#      root GET  /                    static_pages#home
# users_new GET  /users/new(.:format) users#new
#    signup GET  /signup(.:format)    users#new
#     about GET  /about(.:format)     static_pages#about
#      help GET  /help(.:format)      static_pages#help
#   contact GET  /contact(.:format)   static_pages#contact





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

