module DataKitten

  # A license for a {Dataset} or {Distribution}
  #
  class License

    # @!attribute is
    #   @return [String] a short ID that identifies the license.
    attr_accessor :id
    
    # @!attribute name
    #   @return [String] the human name of the license.
    attr_accessor :name
    
    # @!attribute uri
    #   @return [String] the URI for the license text.
    attr_accessor :uri

    # Create a new License object.
    #
    # @param options [Hash] A set of options with which to initialise the license.
    # @option options [String] :id the short ID for the license
    # @option options [String] :name the human name for the license
    # @option options [String] :uri the URI of the license text
    def initialize(options)
      @id = options[:id]
      @name = options[:name]
      @uri = options[:uri]
    end

  end  

end