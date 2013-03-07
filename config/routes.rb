GithubViewer::Application.routes.draw do

  resources :repositories
  root "repositories#index"

end
