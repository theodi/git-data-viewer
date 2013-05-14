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


      def headers
        if metadata['resources'][0]['schema']
          metadata['resources'][0]['schema']['fields'].map{|x| x['id']}
        else
          data.headers
        end
      end  

      def dialect
        metadata['resources'][0]['dialect'] || {
          "delimiter" => ","
        }
      end

      def format
        @format ||= begin
          f = metadata['resources'][0]['format']
          if f.nil?
            f = metadata['resources'][0]['path'].is_a?(String) ? metadata['resources'][0]['path'].split('.').last.upcase : nil
          end
          f.upcase! unless f.nil?
          f
        end
      end
  
      def data
        @data ||= begin
          if metadata['resources'][0]['path'].is_a?(String)
            datafile = load metadata['resources'][0]['path']
          elsif metadata['resources'][0]['url'].is_a?(String)
            datafile = Net::HTTP.get(URI.parse(metadata['resources'][0]['url']))
          end
          if datafile
            CSV.parse(
              datafile, 
              :headers => true,
              :col_sep => dialect["delimiter"]
            )
          else
            nil
          end
        end
      end

      def changelog
        @changelog ||= begin
          if source == :git
            # Get a log for each resource in the local repo
            logs = metadata['resources'].map do |resource|
              if resource['path']
                log = repository.log.path(resource['path'])
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