ActionController::Routing::Routes.draw do |map|
  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month

  map.root :controller => :posts

  map.signup "/signup", :controller => :users, :action => :new
  map.login "/login", :controller => :user_sessions, :action => :new
  map.logout "/logout", :controller => :user_sessions, :action => :destroy

  map.resources :posts

  map.resources :users

  map.resources :user_sessions

  map.resources :comments

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
