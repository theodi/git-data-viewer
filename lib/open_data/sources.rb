require 'open_data/sources/git'

module OpenData
  
  module Sources

    private

    def detect_source
      [
        OpenData::Sources::Git
      ].each do |source|
        extend source if source.supported?(@access_url)
      end
    end

  end
  
end
