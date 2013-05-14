class RepositoriesController < ApplicationController
  
  def index
    @repositories = %w{
      git://github.com/theodi/dataset-mod-disposals.git
      git://github.com/datasets/population.git
      git://github.com/datasets/house-prices-uk.git
      https://github.com/datasets/house-prices-us.git
      git://github.com/datasets/gdp-uk.git
      git://github.com/datasets/cofog.git
      https://github.com/theodi/hot-drinks.git
      https://floppy@bitbucket.org/floppy/hot-drinks.git
    }.map{|uri| Repository.new(uri: uri)}
    
  end
  
  def show
    @repo = Repository.new(uri: params[:uri])
    render :not_supported and return unless @repo.supported?
  end

  def create
    redirect_to repository_path(Repository.new(uri: params[:uri]))
  end
  
end
