module OpenData

  # A person or organisation. Named after foaf:Agent but using schema.org naming for internals
  class Agent

    attr_accessor :name, :uri, :email

    def initialize(options)
      @name = options[:name]
      @uri = options[:uri]
      @email = options[:email]
    end

  end  

end