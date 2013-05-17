require 'open_data/sources'
require 'open_data/hosts'
require 'open_data/publishing_formats'

module OpenData

  # Represents a single dataset from some source (see {http://www.w3.org/TR/vocab-dcat/#class-dataset dcat:Dataset} 
  # for relevant vocabulary).
  #
  # Designed to be created with a URI to the dataset, and then to work out metadata from there.
  # 
  # Currently supports Datasets hosted in Git (and optionally on GitHub), and which 
  # use the Datapackage metadata format.
  #
  # @example Load a Dataset from a git repository
  #   dataset = Dataset.new(access_url: 'git://github.com/theodi/dataset-metadata-survey.git')
  #   dataset.supported?         # => true
  #   dataset.source             # => :git
  #   dataset.host               # => :github
  #   dataset.publishing_format  # => :datapackage
  #   
  class Dataset

    include OpenData::Sources
    include OpenData::Hosts
    include OpenData::PublishingFormats
  
    # @!attribute access_url
    #   @return [String] the URL that gives access to the dataset
    attr_accessor :access_url
    alias_method :uri, :access_url
    alias_method :url, :access_url

    # Create a new Dataset object
    # 
    # @param [Hash] options the details of the Dataset.
    # @option options [String] :access_url A URL that can be used to access the Dataset. 
    #                                      The class will attempt to auto-load metadata from this URL.
    #
    def initialize(options)
      @access_url = options[:access_url]
      detect_source
      detect_host
      detect_publishing_format
    end
  
    # Can metadata be loaded for this Dataset?
    #
    # @return [Boolean] true if metadata can be loaded, false if it's on 
    #                   an unknown hosting type, or has an unknown metadata format.
    def supported?
      source && host && publishing_format
    end
  
    # The source type of the dataset.
    #
    # @return [Symbol] The source type. For instance, datasets loaded from git 
    #                  repositories will return +:git+. If no source type is 
    #                  identified, will return +nil+.
    def source
      nil
    end
    
    # Where the dataset is hosted.
    #
    # @return [Symbol] The host. For instance, data loaded from github repositories 
    #                  will return +:github+. This can be used to control extra host-specific
    #                  behaviour if required. If no host type is identified, will return +nil+.
    def host
      nil
    end
    
    # The publishing format for the dataset.
    #
    # @return [Symbol] The format. For instance, datasets that publish metadata in
    #                  Datapackage format will return +:datapackage+. If no format 
    #                  is identified, will return +nil+.
    def publishing_format
      nil
    end

    # A list of maintainers
    #
    # @return [Array<Agent>] An array of maintainers, each as an Agent object.
    def maintainers
      []
    end

    # A list of publishers
    #
    # @return [Array<Agent>] An array of publishers, each as an Agent object.
    def publishers
      []
    end

    # A list of licenses
    #
    # @return [Array<License>] An array of licenses, each as a License object.
    def licenses
      []
    end

    # A list of contributors
    #
    # @return [Array<Agent>] An array of contributors to the dataset, each as an Agent object.
    def contributors
      []
    end

    # A list of distributions. Has aliases for popular alternative vocabularies.
    #
    # @return [Array<Distribution>] An array of Distribution objects.
    def distributions
      []
    end
    alias_method :files, :distributions
    alias_method :resources, :distributions

    # A history of changes to the Dataset
    #
    # @return [Array] An array of changes. Exact format depends on the source and publishing format.
    def changes
      []
    end

  end
end