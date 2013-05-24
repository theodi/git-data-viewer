module DataKitten
  
  module Sources
    
    # Web service source module. Automatically mixed into {Dataset} for datasets that are accessed through an API.
    #
    # @see Dataset
    #
    module WebService
  
      private
  
      def self.supported?(uri)
        false
      end

      public

      # The source type of the dataset.
      # @return [Symbol] +:web_service+
      # @see Dataset#source
      def source
        :web_service
      end

    end

  end

end