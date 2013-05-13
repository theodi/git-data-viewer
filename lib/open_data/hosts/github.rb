module OpenData

  module Hosts
    
    module Github

      def self.supported?(uri)
        uri =~ /\A(git|https?):\/\/github\.com\//
      end

      def host
        :github
      end

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