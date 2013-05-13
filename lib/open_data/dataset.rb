class OpenData::Dataset
  
  attr_accessor :uri

  def initialize(options)
    @uri = options[:uri]
  end
  
  def stripped_uri
    @stripped_uri ||= begin
      uri = URI.parse(@uri)
      path_without_extension = uri.path.rpartition('.')[0]
      [uri.host, path_without_extension].join('')
    end
  end

  def supported?
    metadata
  end
  
  def metadata
    @metadata ||= begin
      if json = load("datapackage.json")
        JSON.parse(json)
      else
        nil
      end
    end
  end
  
  def maintainers
    metadata && metadata['maintainers'] ? metadata['maintainers'] : []
  end

  def publishers
    metadata && metadata['publishers'] ? metadata['publishers'] : []
  end

  def licenses
    metadata && metadata['licenses'] ? metadata['licenses'] : []
  end

  def contributors
    metadata && metadata['contributors'] ? metadata['contributors'] : []
  end

  def headers
    if metadata
      if metadata['resources'][0]['schema']
        metadata['resources'][0]['schema']['fields'].map{|x| x['id']}
      else
        data.headers
      end
    else
      []
    end
  end  

  def dialect
    metadata['resources'][0]['dialect'] || {
      "delimiter" => ","
    }
  end

  def format
    @format ||= begin
      if metadata
        f = metadata['resources'][0]['format']
        if f.nil?
          f = metadata['resources'][0]['path'].is_a?(String) ? metadata['resources'][0]['path'].split('.').last.upcase : nil
        end
        f.upcase! unless f.nil?
        f
      else
        nil
      end
    end
  end
  
  def data
    @data ||= begin
      if metadata && metadata['resources'][0]['path'].is_a?(String)
        datafile = load metadata['resources'][0]['path']
      elsif metadata && metadata['resources'][0]['url'].is_a?(String)
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

end

require 'open_data/dataset/hosts'
require 'open_data/dataset/sources'