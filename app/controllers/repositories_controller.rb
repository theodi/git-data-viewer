class RepositoriesController < ApplicationController
  
  def index
  end
  
  def show
    url = "https://github.com/#{params[:id]}.git"
    @repo = Repository.new(url: url)
  end
  
end
