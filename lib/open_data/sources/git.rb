module OpenData
  
  module Sources
    
    module Git
  
      private
  
      def self.supported?(uri)
        uri =~ /\A(git|https?):\/\/.*\.git\Z/
      end

      public

      def source
        :git
      end

      def changelog
        @changelog ||= begin
          repository.log.map{|commit| commit}
        end
      end

      protected
  
      def load_file(path)
        # Make sure we have a working copy
        repository
        # read file 
        File.read(File.join(working_copy_path, path))
      end
  
      private
  
      def working_copy_path
        # Create holding directory
        FileUtils.mkdir_p(File.join(Rails.root, 'tmp', 'repositories'))
        # generate working copy dir
        File.join(Rails.root, 'tmp', 'repositories', stripped_uri.gsub('/','-'))
      end

      def repository
        @repository ||= begin
          repo = ::Git.open(working_copy_path)
          repo.pull("origin", "master")
          repo
        rescue ArgumentError
          repo = ::Git.clone(@uri, working_copy_path)
        end
      end  
  
    end

  end

end