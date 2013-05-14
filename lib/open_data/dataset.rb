require 'open_data/sources'
require 'open_data/hosts'
require 'open_data/publishing_formats'

module OpenData

  class Dataset

    include OpenData::Sources
    include OpenData::Hosts
    include OpenData::PublishingFormats
  
    attr_accessor :uri

    def initialize(options)
      @uri = options[:uri]
      detect_source
      detect_host
      detect_publishing_format
    end
  
    def supported?
      source && host && publishing_format
    end
  
    def stripped_uri
      @stripped_uri ||= begin
        uri = URI.parse(@uri)
        path_without_extension = uri.path.rpartition('.')[0]
        [uri.host, path_without_extension].join('')
      end
    end
    
    def source
      nil
    end
    
    def host
      nil
    end
    
    def publishing_format
      nil
    end

  end
end