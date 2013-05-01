require 'net/http'
require 'csv'
require 'uri'
require 'cgi'

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
      if json = Net::HTTP.get(URI.parse("https://raw.github.com/#{github_user_name}/#{github_repository_name}/master/datapackage.json"))
        JSON.parse(json)
      else
        nil
      end
    end
  end

  def headers
    @headers ||= metadata ? metadata['resources'][0]['schema']['fields'].map{|x| x['id']} : []
  end  

  def format
    @format ||= metadata && metadata['resources'][0]['path'].is_a?(String) ? metadata['resources'][0]['path'].split('.').last.upcase : nil
  end
    
  def data
    @data ||= if metadata && metadata['resources'][0]['path'].is_a?(String)
      datafile = Net::HTTP.get(URI.parse("https://raw.github.com/#{github_user_name}/#{github_repository_name}/master/#{metadata['data']}"))
      CSV.parse(datafile, :headers => true)
    else
      nil
    end
  end

end
