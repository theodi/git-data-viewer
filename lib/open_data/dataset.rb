require 'open_data/sources'
require 'open_data/hosts'
require 'open_data/publishing_formats'

module OpenData

  class Dataset

    include OpenData::Sources
    include OpenData::Hosts
    include OpenData::PublishingFormats
  
    attr_accessor :access_url
    alias_method :uri, :access_url

    def initialize(options)
      @access_url = options[:access_url]
      detect_source
      detect_host
      detect_publishing_format
    end
  
    def supported?
      source && host && publishing_format
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