require 'data_kitten/sources/git'

module DataKitten
  
  module Sources

    private

    def detect_source
      [
        DataKitten::Sources::Git
      ].each do |source|
        extend source if source.supported?(@access_url)
      end
    end

  end
  
end
