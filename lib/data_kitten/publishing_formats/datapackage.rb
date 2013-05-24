module DataKitten

  module PublishingFormats
    
    # Datapackage metadata format module. Automatically mixed into {Dataset} for datasets that include a +datapackage.json+.
    #
    # @see Dataset
    #
    module Datapackage

      private

      def self.supported?(instance)
        instance.send(:load_file, "datapackage.json")
      rescue 
        false
      end

      public

      # The publishing format for the dataset.
      # @return [Symbol] +:datapackage+
      # @see Dataset#publishing_format
      def publishing_format
        :datapackage
      end
      
      # A list of maintainers.
      #
      # @see Dataset#maintainers
      def maintainers
        (metadata['maintainers'] || []).map do |x|
          Agent.new(:name => x['name'], :uri => x['web'], :email => x['email'])
        end
      end

      # A list of publishers.
      #
      # @see Dataset#publishers
      def publishers
        (metadata['publishers'] || []).map do |x|
          Agent.new(:name => x['name'], :uri => x['web'], :email => x['email'])
        end
      end

      # A list of licenses.
      #
      # @see Dataset#licenses
      def licenses
        (metadata['licenses'] || []).map do |x| 
          License.new(:id => x['id'], :uri => x['url'], :name => x['name'])
        end
      end

      # A list of contributors.
      #
      # @see Dataset#contributors
      def contributors
        (metadata['contributors'] || []).map do |x|
          Agent.new(:name => x['name'], :uri => x['web'], :email => x['email'])
        end
      end

      # A list of distributions, referred to as +resources+ by Datapackage.
      #
      # @see Dataset#distributions
      def distributions
        metadata['resources'].map { |resource| Distribution.new(self, datapackage_resource: resource) }
      end
  
      # A history of changes to the Dataset.
      # 
      # If {Dataset#source} is +:git+, this is the git changelog for the actual distribution files, rather
      # then the full unfiltered log.
      #
      # @return [Array] An array of changes. Exact format depends on the source.
      # 
      # @see Dataset#change_history
      def change_history
        @change_history ||= begin
          if source == :git
            # Get a log for each file in the local repo
            logs = distributions.map do |file|
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