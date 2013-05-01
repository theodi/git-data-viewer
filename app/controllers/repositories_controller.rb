class RepositoriesController < ApplicationController
  
  def index
    @repositories = %w{
      git://github.com/datasets/house-prices-uk.git
      git://github.com/datasets/gdp-uk.git
      git://github.com/datasets/cofog.git
      https://github.com/theodi/github-viewer-test-data.git
    }.map{|uri| Repository.new(uri: uri)}
    
  end
  
  def show
    @repo = Repository.new(uri: params[:uri])
    render :not_supported and return unless @repo.supported?
    @preview_data = @repo.data.first(10)
  end

  def create
    redirect_to repository_path(Repository.new(uri: params[:uri]))
  end
  
end
