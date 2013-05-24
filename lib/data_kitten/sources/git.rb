module DataKitten
  
  module Sources
    
    # Git source module. Automatically mixed into {Dataset} for datasets that are loaded from Git repositories.
    #
    # @see Dataset
    #
    module Git
  
      private
  
      def self.supported?(uri)
        uri =~ /\A(git|https?):\/\/.*\.git\Z/
      end

      public

      # The source type of the dataset.
      # @return [Symbol] +:git+
      # @see Dataset#source
      def source
        :git
      end

      # A history of changes to the Dataset, taken from the full git changelog
      # @see Dataset#change_history
      def change_history
        @change_history ||= begin
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
        File.join(Rails.root, 'tmp', 'repositories', @access_url.gsub('/','-'))
      end

      def repository
        @repository ||= begin
          repo = ::Git.open(working_copy_path)
          repo.pull("origin", "master")
          repo
        rescue ArgumentError
          repo = ::Git.clone(@access_url, working_copy_path)
        end
      end  
  
    end

  end

end