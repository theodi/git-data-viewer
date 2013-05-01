GithubViewer::Application.routes.draw do

  root "repositories#index"

  get "/repositories" => "repositories#index"
  get "/repositories/:uri" => "repositories#show", :as => :repository, :constraints => { uri: /[^\/]+/ }


end
