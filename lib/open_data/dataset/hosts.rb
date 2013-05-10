module OpenData::Dataset::Hosts
end

require 'open_data/dataset/hosts/github'

class OpenData::Dataset
  
  include OpenData::Dataset::Hosts::Github
  
end