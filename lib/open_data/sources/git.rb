module OpenData
  
  module Sources
    
    module Git
  
      def self.supported?(uri)
        uri =~ /\A(git|https?):\/\/.*\.git\Z/
      end

      def source
        :git
      end

      def changelog
        @changelog ||= begin
          # Get a log for each resource in the local repo
          logs = metadata['resources'].map do |resource|
            if resource['path']
              log = repository.log.path(resource['path'])
              log.map{|x| x}
            else
              []
            end
          end
          # combine all logs, make unique, and re-sort in date order
          logs.flatten.uniq.sort_by{|x| x.committer.date}.reverse
        end
      end

      protected
  
      def load(path)
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