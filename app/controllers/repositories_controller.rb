class RepositoriesController < ApplicationController
  
  def index
    @repositories = [
      Repository.new(uri: "https://github.com/theodi/github-viewer-test-data.git"),
      Repository.new(uri: "git://github.com/datasets/house-prices-uk.git"),
      Repository.new(uri: "git://github.com/datasets/gdp-uk.git")
    ]
  end
  
  def show
    @repo = Repository.new(uri: params[:uri])
    render :not_supported and return unless @repo.supported?
  end

  def create
    redirect_to repository_path(Repository.new(uri: params[:uri]))
  end
  
end
