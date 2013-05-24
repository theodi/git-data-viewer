require 'data_kitten/hosts/github'
require 'data_kitten/hosts/bitbucket'
require 'data_kitten/hosts/gist'

module DataKitten
  
  module Hosts

    private

    def detect_host
      [
        DataKitten::Hosts::Github,
        DataKitten::Hosts::Bitbucket,
        DataKitten::Hosts::Gist
      ].each do |host|
        extend host if host.supported?(@access_url)
      end
    end

  end
  
end