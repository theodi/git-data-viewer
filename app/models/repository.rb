require 'net/http'
require 'csv'
require 'uri'
require 'cgi'
require 'git'

class Repository < ActiveRecord::Base

  attr_accessor :uri
  
  def stripped_uri
    @stripped_uri ||= begin
      uri = URI.parse(@uri)
      path_without_extension = uri.path.rpartition('.')[0]
      [uri.host, path_without_extension].join('')
    end
  end

  def to_param
    CGI.escape(@uri).gsub('.','%2E')
  end
  
  def supported?
    hosted_by_github? && metadata
  end
  
  def hosted_by_github?
    (@uri =~ /\A(git|https?):\/\/github\.com\//).present?
  end

  def github_user_name
    @github_user_name ||= hosted_by_github? ? uri.split('/')[-2] : nil
  end
  
  def github_repository_name
    @github_repository_name ||= hosted_by_github? ? uri.split('/')[-1].split('.')[0] : nil
  end

  def repository
    @repository ||= $github.repos.get github_user_name, github_repository_name
  end

  def commits
    @commits ||= $github.repos.commits.all github_user_name, github_repository_name
  end

  def metadata
    @metadata ||= begin
      update_working_copy
      if json = File.read(File.join(working_copy, "datapackage.json"))
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
        datafile = File.read(File.join(working_copy, metadata['resources'][0]['path']))
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

  private
  
  def working_copy
    # Create holding directory
    FileUtils.mkdir_p(File.join(Rails.root, 'tmp', 'repositories'))
    # generate working copy dir
    File.join(Rails.root, 'tmp', 'repositories', stripped_uri.gsub('/','-'))
  end

  def update_working_copy
    begin
      repo = Git.open(working_copy)
      repo.pull("origin", "master")
    rescue ArgumentError
      repo = Git.clone(@uri, working_copy)
    end
    repo
  end

end
