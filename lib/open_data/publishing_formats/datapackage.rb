module OpenData

  module PublishingFormats
    
    module Datapackage

      private

      def self.supported?(instance)
        instance.send(:load_file, "datapackage.json")
      rescue 
        false
      end

      public

      def publishing_format
        :datapackage
      end
      
      def maintainers
        (metadata['maintainers'] || []).map do |x|
          Agent.new(:name => x['name'], :uri => x['web'], :email => x['email'])
        end
      end

      def publishers
        (metadata['publishers'] || []).map do |x|
          Agent.new(:name => x['name'], :uri => x['web'], :email => x['email'])
        end
      end

      def licenses
        (metadata['licenses'] || []).map do |x| 
          License.new(:id => x['id'], :uri => x['url'], :name => x['name'])
        end
      end

      def contributors
        (metadata['contributors'] || []).map do |x|
          Agent.new(:name => x['name'], :uri => x['web'], :email => x['email'])
        end
      end

      def files
        metadata['resources'].map { |resource| Datafile.new(self, datapackage_resource: resource) }
      end
  
      def changelog
        @changelog ||= begin
          if source == :git
            # Get a log for each file in the local repo
            logs = files.map do |file|
              if file.path
                log = repository.log.path(file.path)
                # Convert to list of commits
                log.map{|commit| commit}
              else
                []
              end
            end
            # combine all logs, make unique, and re-sort in date order
            logs.flatten.uniq.sort_by{|x| x.committer.date}.reverse
          else
            []
          end
        end
      end

      private
      
      def metadata
        @metadata ||= begin
          if json = load_file("datapackage.json")
            JSON.parse(json)
          else
            nil
          end
        end
      end

    end

  end
  
end