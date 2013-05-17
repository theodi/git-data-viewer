module DataKitten

  module Hosts
    
    # GitHub host module. Automatically mixed into {Dataset} for datasets that are loaded from GitHub.
    #
    # @see Dataset
    #
    module Github

      private

      def self.supported?(uri)
        uri =~ /\A(git|https?):\/\/github\.com\//
      end
      
      public

      # Where the dataset is hosted.
      # @return [Symbol] +:github+
      # @see Dataset#host
      def host
        :github
      end

      # Helper for generating GitHub URLs
      #
      # @param path [String] The path to append to the GitHub base URL.
      #
      # @return [String] The supplied path with the GitHub base URL prepended
      #
      # @example
      #   dataset = Dataset.new(access_url: 'git://github.com/theodi/dataset-metadata-survey.git')
      #   dataset.github_path           # => 'https://github.com/theodi/dataset-metadata-survey/'
      #   dataset.github_path('issues') # => 'https://github.com/theodi/dataset-metadata-survey/issues'
      def github_path(path = '')
        "https://github.com/#{github_user_name}/#{github_repository_name}/#{path}"
      end

      private

      def github_user_name
        @github_user_name ||= uri.split('/')[-2]
      end
  
      def github_repository_name
        @github_repository_name ||= uri.split('/')[-1].split('.')[0]
      end

    end

  end
  
end