class RepositoriesController < ApplicationController
  
  def index
  end
  
  def show
    uri = "https://github.com/#{params[:id]}.git"
    @repo = Repository.new(uri: uri)
  end
  
end
