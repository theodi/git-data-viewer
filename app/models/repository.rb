require 'data_kitten'

class Repository < ActiveRecord::Base

  def initialize(options)
    @dataset = DataKitten::Dataset.new(access_url: options.delete(:uri))
    super
  end
  
  def to_param
    CGI.escape(@dataset.uri).gsub('.','%2E')
  end
  
  # Delegate everything to the dataset object
  def method_missing(*args)
    begin
      super
    rescue NoMethodError
      @dataset.send(*args)
    end
  end
  
end
