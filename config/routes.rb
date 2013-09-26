Retwitr::Application.routes.draw do

devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

root :to => 'welcome#index'

get 'sessions/create', :to => 'sessions#create'
get 'auth/:provider/callback', :to => 'sessions#create'
delete 'logout', :to => 'sessions#destroy', :as => 'logout'
get '/search', :to => 'search#form' 
post '/search', :to => 'search#results'

get 'search/add_search', :to => 'search#add_search', :as => 'add_search'
post 'search/add_search', :to => 'search#add_search', :as => 'add_search'
end
