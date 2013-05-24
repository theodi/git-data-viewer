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

    # @!attribute type
    #   @return [String] the type of information this license applies to. Could be +:data+ or +:content+.
    attr_accessor :type

    # Create a new License object.
    #
    # @param options [Hash] A set of options with which to initialise the license.
    # @option options [String] :id the short ID for the license
    # @option options [String] :name the human name for the license
    # @option options [String] :uri the URI of the license text
    # @option options [String] :type the type of information covered by this license.
    def initialize(options)
      @id = options[:id]
      @name = options[:name]
      @uri = options[:uri]
      @type = options[:type]
    end

  end  

end