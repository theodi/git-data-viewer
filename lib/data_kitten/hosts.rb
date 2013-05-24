require 'data_kitten/hosts/github'
require 'data_kitten/hosts/bitbucket'

module DataKitten
  
  module Hosts

    private

    def detect_host
      [
        DataKitten::Hosts::Github,
        DataKitten::Hosts::Bitbucket
      ].each do |host|
        extend host if host.supported?(@access_url)
      end
    end

  end
  
end