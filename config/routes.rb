GithubViewer::Application.routes.draw do

  root "repositories#index"

  get "/repositories" => "repositories#index"
  post "/repositories" => "repositories#create", :as => :create_repository

  get "/repositories/:uri" => "repositories#show", :as => :repository, :constraints => { uri: /[^\/]+/ }



end
