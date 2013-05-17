require 'data_kitten/sources/git'
require 'data_kitten/sources/web_service'

module DataKitten
  
  module Sources

    private

    def detect_source
      [
        DataKitten::Sources::Git,
        DataKitten::Sources::WebService
      ].each do |source|
        extend source if source.supported?(@access_url)
      end
    end

  end
  
end
