module DataKitten

  module Hosts
    
    # Bitbucket host module. Automatically mixed into {Dataset} for datasets that are loaded from Bitbucket.
    #
    # @see Dataset
    #
    module Bitbucket

      private

      def self.supported?(uri)
        uri =~ /\A(git|https?):\/\/[^\/]*bitbucket\.org\//
      end
      
      public

      # Where the dataset is hosted.
      # @return [Symbol] +:bitbucket+
      # @see Dataset#host
      def host
        :bitbucket
      end

      # Helper for generating Bitbucket URLs
      #
      # @param path [String] The path to append to the Bitbucket base URL.
      #
      # @return [String] The supplied path with the Bitbucket base URL prepended
      #
      # @example
      #   dataset = Dataset.new(access_url: 'https://bitbucket.org/floppy/hot-drinks.git')
      #   dataset.bitbucket_path           # => 'https://bitbucket.org/floppy/hot-drinks/'
      #   dataset.bitbucket_path('pull-requests') # => 'https://bitbucket.org/floppy/hot-drinks/pull-requests'
      def bitbucket_path(path = '')
        "https://bitbucket.org/#{bitbucket_user_name}/#{bitbucket_repository_name}/#{path}"
      end

      private

      def bitbucket_user_name
        @bitbucket_user_name ||= uri.split('/')[-2]
      end
  
      def bitbucket_repository_name
        @bitbucket_repository_name ||= uri.split('/')[-1].split('.')[0]
      end

    end

  end
  
end