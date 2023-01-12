Rails.application.routes.draw do
  get "welcome/index"
  get "welcome/user_session"

  get "component/:name/:session_id" => "component#name", :as => :component_named_default
  get "component/:name/expanded/:session_id" => "component#name", :as => :component_named_expanded
  get "component/:name/settings/:session_id" => "component#name", :as => :component_named_settings

  root "welcome#index"
end
