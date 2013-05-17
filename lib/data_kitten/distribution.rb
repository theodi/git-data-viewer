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

    # @!attribute uri
    #   @return [String] a URI to access the distribution.
    attr_accessor :uri

    # @!attribute path
    #   @return [String] a relative path with the current source to access the distribution.
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
        @uri = r['url']
      end
    end

    # A usable name for the distribution, unique within the {Dataset}.
    #
    # @return [String] either path or uri, depending on which is present.
    def name
      @path || @uri
    end

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
        elsif @uri
          datafile = Net::HTTP.get(URI.parse(@uri))
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

  end  

end