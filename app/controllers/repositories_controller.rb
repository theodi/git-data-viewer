require 'csv'

class RepositoriesController < ApplicationController
  
  def index
  end
  
  def show
    # Get user and repository
    @user, @repo = params[:id].split('/', 2)
    # Get git data
    @repository = $github.repos.get @user, @repo
    # Get metadata
    if json = Net::HTTP.get(URI.parse("https://raw.github.com/#{@user}/#{@repo}/master/metadata.json"))
      @metadata = JSON.parse(json)
      # Store headers
      @headers = @metadata['definitions'].map{|x| x['label']}
      # Get data file
      if @metadata['data'].is_a?(String)
        datafile = Net::HTTP.get(URI.parse("https://raw.github.com/#{@user}/#{@repo}/master/#{@metadata['data']}"))
        @data = CSV.parse(datafile, :headers => true)
      end
    end
  end
  
end
