module DataKitten

  # A specific available form of a dataset, such as a CSV file, and API, or an RSS feed.
  #
  # Based on {http://www.w3.org/TR/vocab-dcat/#class-distribution dcat:Distribution}, but 
  # with useful aliases for other vocabularies.
  #
  class Distribution

    # @!attribute format
    #   @return [String] the file format of the distribution.
    attr_accessor :format

    # @!attribute access_url
    #   @return [String] a URL to access the distribution.
    attr_accessor :access_url
    alias_method :uri, :access_url
    alias_method :download_url, :access_url

    # @!attribute path
    #   @return [String] the path of the distribution within the source, if appropriate
    attr_accessor :path

    # @!attribute description
    #   @return [String] a textual description
    attr_accessor :description

    # @!attribute description
    #   @return [Hash] a hash representing the schema of the data within the distribution. Will
    #                  change to a more structured object later.
    attr_accessor :schema

    # Create a new Distribution. Currently only loads from Datapackage +resource+ hashes.
    #
    # @param dataset [Dataset] the {Dataset} that this is a part of.
    # @param options [Hash] A set of options with which to initialise the distribution.
    # @option options [String] :datapackage_resource the +resource+ section of a Datapackage 
    #                                                representation to load information from.
    def initialize(dataset, options) 
      # Store dataset
      @dataset = dataset
      # Parse datapackage
      if r = options[:datapackage_resource]
        # Load basics
        @description = r['description']
        # Work out format
        @format = begin
          f = r['format']
          if f.nil?
            f = r['path'].is_a?(String) ? r['path'].split('.').last.upcase : nil
          end
          f.upcase! unless f.nil?
          f
        end
        # Get CSV dialect
        @dialect = r['dialect'] || {
          "delimiter" => ","
        }
        # Extract schema
        @schema = r['schema']
        # Get path
        @path = r['path']
        @access_url = r['url']
      end
    end

    # A usable name for the distribution, unique within the {Dataset}.
    #
    # @return [String] a locally unique name
    def title
      @path || @uri
    end
    alias_method :name, :title

    # An array of column headers for the distribution. Loaded from the schema, or from the file directly if no
    # schema is present.
    #
    # @return [Array<String>] an array of column headers, as strings.
    def headers
      @headers ||= begin
        if @schema
          @schema['fields'].map{|x| x['id']}
        else
          data.headers
        end
      end
    end

    # A CSV object representing the loaded data.
    #
    # @return [Array<Array<String>>] an array of arrays of strings, representing each row.
    def data
      @data ||= begin
        if @path
          datafile = @dataset.send(:load_file, @path)
        elsif @access_url
          datafile = Net::HTTP.get(URI.parse(@access_url))
        end
        if datafile
          CSV.parse(
            datafile, 
            :headers => true,
            :col_sep => @dialect["delimiter"]
          )
        else
          nil
        end
      end
    end      

    # Is the information in a structured format?
    #
    # @return [Boolean] whether the information is machine-readable.
    def structured_format?
      format == 'CSV'
    end


  end  

end