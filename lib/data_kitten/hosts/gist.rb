module DataKitten

  module Hosts
    
    # Gist host module. Automatically mixed into {Dataset} for datasets that are loaded from Gist.
    #
    # @see Dataset
    #
    module Gist

      private

      def self.supported?(uri)
        uri =~ /\A(git|https?):\/\/gist\.github\.com\//
      end
      
      public

      # Where the dataset is hosted.
      # @return [Symbol] +:gist+
      # @see Dataset#host
      def host
        :gist
      end

      # Helper for generating Gist URLs
      #
      # @param path [String] The path to append to the Gist base URL.
      #
      # @return [String] The supplied path with the Gist base URL prepended
      #
      # @example
      #   dataset = Dataset.new(access_url: 'git://gist.github.com/5633865.git')
      #   dataset.gist_path           # => 'https://gist.github.com/5633865'
      #   dataset.gist_path('download') # => 'https://gist.github.com/5633865/download'
      def gist_path(path = '')
        "https://gist.github.com/#{gist_repository_name}/#{path}"
      end

      private

      def gist_repository_name
        @gist_repository_name ||= uri.split('/')[-1].split('.')[0]
      end

    end

  end
  
end