module OpenData

  class Distribution

    attr_accessor :format, :uri, :path, :description, :schema

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

    def name
      @path || @uri
    end

    def headers
      @headers ||= begin
        if @schema
          @schema['fields'].map{|x| x['id']}
        else
          data.headers
        end
      end
    end

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