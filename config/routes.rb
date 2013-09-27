Retwitr::Application.routes.draw do

devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

root :to => 'welcome#index'

get 'sessions/create', :to => 'sessions#create'
get 'auth/:provider/callback', :to => 'sessions#create'
delete 'logout', :to => 'sessions#destroy', :as => 'logout'
get '/user/:id', :to => 'user#index', :as => 'user'
get '/search', :to => 'search#form' 
post '/search', :to => 'search#results'
get '/search/add_search', :to => 'search#add_search', :as => 'add_search'
get '/search/:id', :to => 'search#view'
post '/search/add_search', :to => 'search#add_search', :as => 'add_search'
get '/search/delete/:id', :to => 'search#remove', :as => 'remove_search'

end