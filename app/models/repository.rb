require 'net/http'
require 'csv'

class Repository < ActiveRecord::Base

  attr_accessor :url
  
  def hosted_by_github?
    url =~ /\Ahttps?:\/\/github\.com\//
  end

  def github_user_name
    @github_user_name ||= hosted_by_github? ? url.split('/')[-2] : nil
  end
  
  def github_repository_name
    @github_repository_name ||= hosted_by_github? ? url.split('/')[-1].split('.')[0] : nil
  end

  def repository
    @repository ||= $github.repos.get github_user_name, github_repository_name
  end

  def commits
    @commits ||= $github.repos.commits.all github_user_name, github_repository_name
  end

  def metadata
    @metadata ||= begin
      if json = Net::HTTP.get(URI.parse("https://raw.github.com/#{github_user_name}/#{github_repository_name}/master/metadata.json"))
        JSON.parse(json)
      else
        nil
      end
    end
  end

  def headers
    @headers ||= metadata ? metadata['definitions'].map{|x| x['label']} : []
  end  

  def format
    @format ||= metadata && metadata['data'].is_a?(String) ? metadata['data'].split('.').last.upcase : nil
  end
    
  def data
    @data ||= if metadata && metadata['data'].is_a?(String)
      datafile = Net::HTTP.get(URI.parse("https://raw.github.com/#{github_user_name}/#{github_repository_name}/master/#{metadata['data']}"))
      CSV.parse(datafile, :headers => true)
    else
      nil
    end
  end

end
