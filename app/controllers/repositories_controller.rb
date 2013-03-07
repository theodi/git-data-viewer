class RepositoriesController < ApplicationController
  
  def index
  end
  
  def show
    # Get user and repository
    @user, @repo = params[:id].split('/', 2)
    # Get git data
    @repository = $github.repos.get @user, @repo
    
    
  end
  
end
