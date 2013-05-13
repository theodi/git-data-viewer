module OpenData::Dataset::Sources
end

require 'open_data/dataset/sources/git'

class OpenData::Dataset
  
  include OpenData::Dataset::Sources::Git
  
end