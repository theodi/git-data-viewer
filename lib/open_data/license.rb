module OpenData

  class License

    attr_accessor :id, :name, :uri

    def initialize(options)
      @id = options[:id]
      @name = options[:name]
      @uri = options[:uri]
    end

  end  

end