class RepositoriesController < ApplicationController
  
  def index
    @repositories = [
      Repository.new(uri: "https://github.com/theodi/github-viewer-test-data.git"),
      Repository.new(uri: "git://github.com/datasets/house-prices-uk.git"),
      Repository.new(uri: "git://github.com/datasets/gdp-uk.git")
    ]
  end
  
  def show
    uri = "https://github.com/#{params[:id]}.git"
    @repo = Repository.new(uri: uri)
  end
  
end
