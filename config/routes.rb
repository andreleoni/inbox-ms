Rails.application.routes.draw do
  namespace :v1 do
    get "messages", to: "messages#index"
  end
end
