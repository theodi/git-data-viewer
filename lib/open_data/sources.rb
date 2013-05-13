require 'open_data/sources/git'

module OpenData
  
  module Sources

    def detect_source
      [
        OpenData::Sources::Git
      ].each do |source|
        extend source if source.supported?(@uri)
      end
    end

  end
  
end
